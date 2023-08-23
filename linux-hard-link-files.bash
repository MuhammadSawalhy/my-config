#!/bin/bash

PS4='$LINENO: '
set -e
shopt -s dotglob

print_help () {
cat <<EOF
OPTIONS:
──┬──────────────┬───────────────────────────────────────────────────
-h│ --help       │ help message, displays this message and ignore all options
-r│ --reverse    │ files in ./linux will be linked to your \$HOME (--fill is not activated)
  │ --force      │ all files will be linked forcely "ln -f"
──┴──────────────┴───────────────────────────────────────────────────
EOF
}

# detecting options
is_merged_arg() {
  arg=${1:1}; shift
  # return with error
  test ${#arg} -eq $# || return 1;
  for a in "$@"; do
    test "$(expr index "$arg" "$a")" -gt 0 || return 1
  done
  echo 1
}

for o in "$@"; do
  [ "$o" = "-h"           ] && is_help=1       && break
  [ "$o" = "--help"       ] && is_help=1       && break
  [ "$o" = "-r"           ] && is_reverse=1    && continue
  [ "$o" = "--reverse"    ] && is_reverse=1    && continue
  [ "$o" = "--force"      ] && is_force=1      && continue

  [ "$(is_merged_arg "$o" r h)"     ] && is_help=1 && continue

  echo unknown options \""$o"\" >&2
  exit 1
done

((is_help)) && print_help && exit

readarray -t patterns < <(sed "/^\s*#\|^\s*$/ d" ./linux-linked-files.txt)

__dirname="$(dirname "$(realpath "$0")")"

if [ "$is_reverse" ]; then
  SOURCE="$__dirname/linux"
  TARGET="$HOME"
else
  SOURCE="$HOME"
  TARGET="$__dirname/linux"
fi

SOURCE_FILES=/tmp/source-files-qoiweru
TARGET_FILES=/tmp/target-files-qoiweru

node ./linux-linked-files.js "$TARGET" "${patterns[@]}" > "$TARGET_FILES"
node ./linux-linked-files.js "$SOURCE" "${patterns[@]}" > "$SOURCE_FILES"

readarray -t source_files < "$SOURCE_FILES"
readarray -t target_files < "$TARGET_FILES"

if [ ! "$is_reverse" ]; then
  # deleted_files only working if NOT targeting the home
  readarray -t deleted_files < <(
    comm -23 \
    <(printf '%s\n' "${target_files[@]}" | sort) \
    <(printf '%s\n' "${source_files[@]}" | sort)
  )

  if test "${deleted_files[*]}" == ""; then
    deleted_files=()
  fi
fi

if [ ! "$is_force" ]; then
  # filter out existing files in the target directory
  readarray -t source_files < <(
    comm -13 \
    <(printf '%s\n' "${target_files[@]}" | sort) \
    <(printf '%s\n' "${source_files[@]}" | sort)
  )

  if test "${source_files[*]}" == ""; then
    source_files=()
  fi
fi

confirm () {
  echo
  echo "$SOURCE" -\> "$TARGET"
  read -r -p "🔥 Are you sure? [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY]) true ;;
    *) exit 1 ;;
  esac
}

if ((${#deleted_files[@]})) || ((${#source_files[@]})); then
  ((${#deleted_files[@]})) && printf -- "- %s\n" "${deleted_files[@]}"
  ((${#source_files[@]})) && printf -- "+ %s\n" "${source_files[@]}"
  confirm
else
  echo ✨ Nothing to do!
  exit 0
fi

if ((${#deleted_files[@]})); then
  echo -\> rm "${deleted_files[@]/#/$TARGET\/}"
  rm "${deleted_files[@]/#/$TARGET\/}"
fi

force_opt=$([ "$is_force" ] && echo '-f' || echo '')
for f in "${source_files[@]}"; do
  mkdir -p "$(dirname "$TARGET/$f")"
  echo -\> ln $force_opt "$SOURCE/$f" "$TARGET/$f"
  ln $force_opt "$SOURCE/$f" "$TARGET/$f"
done

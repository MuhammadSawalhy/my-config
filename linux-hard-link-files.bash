#!/bin/bash

PS4='$LINENO: '
set -e
shopt -s dotglob

print_help () {
cat <<EOF
USAGE:
$0 [--help] [--reverse] [--force] [filtering_pattern]
$0 -r --force '.*nvim\\/lua.*'

OPTIONS:
──┬──────────────┬───────────────────────────────────────────────────
-h│ --help       │ help message, displays this message and ignore all options
-r│ --reverse    │ files in ./linux will be linked to your \$HOME (--fill is not activated)
  │ --force      │ all files will be linked forcely "ln -f"
──┴──────────────┴───────────────────────────────────────────────────
EOF
}

parse_args() {
  for o in "$@"; do
    [ "$o" = "-h"           ] && is_help=1       && break
    [ "$o" = "--help"       ] && is_help=1       && break
    [ "$o" = "-r"           ] && is_reverse=1    && continue
    [ "$o" = "--reverse"    ] && is_reverse=1    && continue
    [ "$o" = "--force"      ] && is_force=1      && continue

    if [[ "$o" =~ ^- ]]; then
      echo unknown options \""$o"\" >&2
      exit 1
    fi

    if [ "$filtering_pattern" ]; then
      echo you can only specify one filtering pattern >&2
      exit 1
    fi

    filtering_pattern="$o"
  done

  ((is_help)) && print_help && exit

  [ "$filtering_pattern" ] || filtering_pattern='.*'
}

get_files() {
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

  readarray -t source_files < <(sed -n "/$filtering_pattern/ p" "$SOURCE_FILES")
  readarray -t target_files < <(sed -n "/$filtering_pattern/ p" "$TARGET_FILES")

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
}

confirm () {
  if ! ((${#deleted_files[@]})) && ! ((${#source_files[@]})); then
    echo ✨ Nothing to do!
    exit 0
  fi

  ((${#deleted_files[@]})) && printf -- "- %s\n" "${deleted_files[@]}"
  ((${#source_files[@]})) && printf -- "+ %s\n" "${source_files[@]}"
  echo
  echo "$SOURCE" -\> "$TARGET"
  read -r -p "🔥 Are you sure? [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY]) true ;;
    *) exit 1 ;;
  esac
}

go() {
  if ((${#deleted_files[@]})); then
    echo -\> rm "${deleted_files[@]/#/$TARGET\/}"
    rm "${deleted_files[@]/#/$TARGET\/}"
  fi

  force_opt=$([ "$is_force" ] && echo '-f' || echo '')
  for f in "${source_files[@]}"; do
    mkdir -p "$(dirname "$TARGET/$f")"
    echo -\> ln "$force_opt" "$SOURCE/$f" "$TARGET/$f"
    ln "$force_opt" "$SOURCE/$f" "$TARGET/$f"
  done
}

parse_args "$@"
get_files
confirm
go

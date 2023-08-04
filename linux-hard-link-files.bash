#!/bin/bash

PS4='$LINENO: '
set -e
shopt -s dotglob

print_help () {
cat <<EOF
OPTIONS:
──┬──────────────┬───────────────────────────────────────────────────
-h│ --help       │ help message, displays this message and ignore all options
-d│ --dry        │ no real phsical changes will happen
-f│ --fill       │ only missing files will be linked (default when HOME -> ./linux)
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
  [ "$o" = "-d"           ] && is_dry=1        && continue
  [ "$o" = "--dry"        ] && is_dry=1        && continue
  [ "$o" = "-r"           ] && is_reverse=1    && continue
  [ "$o" = "--reverse"    ] && is_reverse=1    && continue
  [ "$o" = "-f"           ] && is_fill=1       && continue
  [ "$o" = "--fill"       ] && is_fill=1       && continue
  [ "$o" = "--force"      ] && is_force=1      && continue

  [ "$(is_merged_arg "$o" r d)"   ] && is_dry=1  && is_reverse=1 && continue
  [ "$(is_merged_arg "$o" r f)"   ] && is_fill=1 && is_reverse=1 && continue
  [ "$(is_merged_arg "$o" d f)"   ] && is_dry=1  && is_fill=1    && continue
  [ "$(is_merged_arg "$o" r d f)" ] && is_dry=1  && is_fill=1    &&
    is_reverse=1 && continue

  [ "$(is_merged_arg "$o" r h)"     ] && is_help=1 && continue
  [ "$(is_merged_arg "$o" f h)"     ] && is_help=1 && continue
  [ "$(is_merged_arg "$o" d h)"     ] && is_help=1 && continue
  [ "$(is_merged_arg "$o" r d h)"   ] && is_help=1 && continue
  [ "$(is_merged_arg "$o" r f h)"   ] && is_help=1 && continue
  [ "$(is_merged_arg "$o" d f h)"   ] && is_help=1 && continue
  [ "$(is_merged_arg "$o" r d f h)" ] && is_help=1 && continue

  echo unknown options \""$o"\" >&2
  exit 1
done

((is_help)) && print_help && exit

if [ "$is_fill" ] && [ "$is_force" ]; then
  >&2 echo can\'t pass both force and fill options!
  exit 1
elif [ ! "$is_force" ] && [ ! "$is_reverse" ]; then
  is_fill=1
fi

if [ "$is_reverse" ]; then
  readarray -t patterns < <(find linux -type f | sed 's/^linux\///')
else
  # remove empty lines and comments
  readarray -t patterns < <(sed "/^\s*#\|^\s*$/ d" ./linux-linked-files.txt)
fi

# echo "${patterns[@]}"
# echo ===========================
# echo DRY="$is_dry" REVERSE="$is_reverse" FORCE="$is_force" FILL="$is_fill"
# echo ===========================
# DRY="$is_dry" REVERSE="$is_reverse" FORCE="$is_force" FILL="$is_fill" \
#   node ./linux-linked-files.js "${patterns[@]}"
# exit

LINKED_FILES_FILE=/tmp/linked-files-qoiweru

DRY="$is_dry" REVERSE="$is_reverse" \
FORCE="$is_force" FILL="$is_fill" \
node ./linux-linked-files.js "${patterns[@]}" > $LINKED_FILES_FILE

(($?)) && exit 1 # exit when an error detected

readarray -t files < $LINKED_FILES_FILE

if [ ! "$is_reverse" ]; then
  # deleted_files only working when not reversing
  readarray -t deleted_files < <(
    comm -23 \
    <(find linux -type f | sed -e 's:linux/::' | sort) \
    <(printf '%s\n' "${files[@]}" | sort)
  )
fi

if [ "$is_fill" ]; then
  readarray -t files < <(
    comm -13 \
    <(find linux -type f | sed -e 's:linux/::' | sort) \
    <(printf '%s\n' "${files[@]}" | sort)
  )
fi

((${#deleted_files[@]})) &&
  printf -- "- %s\n" "${deleted_files[@]}"
((${#files[@]})) &&
  printf -- "+ %s\n" "${files[@]}"
[ "$is_dry" ] && exit

((${#deleted_files[@]})) &&
rm "${deleted_files[@]/#/linux\/}"

force_opt=$([ "$is_force" ] && echo '-f' || echo '')
for f in "${files[@]}"; do
  if [ "$is_reverse" ]; then
    ln $force_opt "./linux/$f" "$HOME/$f"
  else
    ln $force_opt "$HOME/$f" "./linux/$f"
  fi
done

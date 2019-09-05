#/bin/bash
function _vasttrafik_completion(){
  if [ "${#COMP_WORDS[@]}" != 2 ]; then
    return
  fi

  local s="${COMP_WORDS[1]}"

  if [ "${s:0:1}" == "'" ]; then
    # strip leading single quote
    s="${s:1}"
  elif [ "${s:0:1}" == "\"" ]; then
    # strip leading double quote and unescape $, `, " and \\
    s="${s:1}"
    s="$(echo "$s" | sed 's/\\\([\$`"\\]\)/\1/g')"
  else
    # unescape all escaped characters (escaped newline is not handled)
    s="$(echo "$s" | sed 's/\\\(.\)/\1/g')"
  fi

  # remove all backslashes
  s="${s//\\/}"

  # quote basic regex special characters
  s="$(escape_basic_regex "$s")"

  # debug
  #export FOO="$s"

  # use line-separated output from grep; thus set IFS
  local old_IFS="$IFS"
  IFS=$'\n'
  #local -a matches=($(grep -P -i "^\Q$s\E" allstops))
  local -a matches=($(grep -i "^$s" allstops))
  IFS="$old_IFS"

  if [ "${COMP_WORDS[1]:0:1}" == "\"" ]; then
    # String starts with double quote: in this case don't quote because
    # bash adds a closing double quote.
    # We should escape special characters here, but there don't seem to be
    # any in the station names.
    COMPREPLY=("${matches[@]}")
  elif [ "${COMP_WORDS[1]:0:1}" == "'" ]; then
    # Input starts with single quote, so single-quote the string
    COMPREPLY=("${matches[@]@Q}")
  else
    # Backslash-escape special characters in all matches
    # TODO: Don't do this when the common prefix of all matches doesn't contain
    #       special characters.
    COMPREPLY=()
    for m in "${matches[@]}" ; do
      COMPREPLY+=("$(escape_specials "$m")")
    done
  fi
}

function escape_specials(){
  echo "$1" | sed 's/\([^a-zA-Z0-9åäöÅÄÖé\\-]\)/\\\1/g'
}

function escape_basic_regex(){
  echo "$1" | sed 's/\([^a-zA-Z0-9åäöÅÄÖé()\\-]\)/\\\1/g'
}

complete -F _vasttrafik_completion vasttrafik

_nimble() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(nimble commands)" -- "$word") )
  else
    local command="${COMP_WORDS[1]}"
    local completions="$(nimble completions "$command" "${COMP_WORDS[@]:2}")"
    COMPREPLY=( $(compgen -W "$completions" -- "$word") )
  fi
}

complete -o nosort -F _nimble nimble

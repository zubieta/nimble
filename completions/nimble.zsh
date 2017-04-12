if [[ ! -o interactive ]]; then
    return
fi

compctl -K _nimble nimble

_nimble() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(nimble commands)"
  else
    completions="$(nimble completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}

up() {
  local p= i=${1:-1}
  while (( i-- )); do
    p+=../
  done
  cd "$p$2" && pwd
}

alias ..='up'

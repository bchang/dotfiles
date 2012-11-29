export DOSCREEN=false

if [ "$DOSCREEN" = "true" ] \
    && [ -n "$SSH_CLIENT" ] \
    && [ -z "$NX_CLIENT" ] \
    && echo "$-" | grep i > /dev/null; then
  if [ "$TERM" != "screen" ]; then
    echo "in ssh terminal"
    numdetached=$(screen -ls | grep "Detached" | wc -l)
    case "$numdetached" in
    0)
      screenopts="" ;;
    1)
      screenopts="-r" ;;
    *)
    # if there are detached screen sessions, show a list
      screen -ls
      echo "Choose a screen to connect to, or enter to choose first:"
      read sel
      {
        if [ -z "$sel" ]; then
          sel=$(screen -ls | grep -m 1 "Detached" | awk '{print $1}')
        fi
        screenopts="-r $sel"
      }
      ;;
    esac
    screen $screenopts && exit
  else
    echo "in screen terminal"
  fi
fi


path=$(pwd)
user=$(whoami)

if pgrep -x "Xorg" >/dev/null; then
  echo "Do you want to harden your Firefox? (y/n)"
  read answer
  sleep 1 && clear

  case $answer in
    [Yy]*)
      echo "Hardening Firefox..."

      if ! command -v wget >/dev/null; then
        echo "wget is not installed. Installing..."
        yay -S wget --noconfirm
        sleep 1 && clear
      fi

      if pgrep firefox >/dev/null; then
        pkill firefox
      fi

      for profile_dir in "$HOME/.mozilla/firefox/"*.default-release/; do
        if [ -f "$profile_dir/user.js" ]; then
          rm "$profile_dir/user.js"
        fi

        if [ -f "$profile_dir/search.json.mozlz4" ]; then
          rm "$profile_dir/search.json.mozlz4"
        fi
      done

      for file in "$path/.config/firefox/"*; do
        cp -r "$file" "$profile_dir"
      done

      ublock_version="1.50.0"
      wget -O "/tmp/uBlock0_$ublock_version.firefox.signed.xpi" "https://github.com/gorhill/uBlock/releases/download/$ublock_version/uBlock0_$ublock_version.firefox.signed.xpi"
      setsid -f firefox "/tmp/uBlock0_$ublock_version.firefox.signed.xpi"

      sleep 1 && clear
      ;;
    [Nn]*)
      echo "Skipping..."
      sleep 1 && clear
      ;;
    *)
      echo "Invalid answer, skipping..."
      sleep 1 && clear
      ;;
  esac
fi

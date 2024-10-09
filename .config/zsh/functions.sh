# ~/.config/zsh/functions.sh

# ======================== Yt-dlp ========================
yt() {
  # Choose media type (video or audio)
  media_type=$(echo -e "video\naudio" | fzf --header "1. Select Media Type" --reverse)

  # Set the download location based on media type
  if [[ "$media_type" == "video" ]]; then
    download_location=~/Videos
    # Ask for resolution (default (1080p), 720p, etc.)
    resolution=$(echo -e "default (1080p)\n720p\n480p\n360p" | fzf --header "2. Select Video Resolution" --reverse)

    # Choose video format (default, mp4)
    video_type=$(echo -e "default\nmp4" | fzf --header "3. Select Video Format" --reverse)

    if [[ "$resolution" == "default (1080p)" ]]; then
      resolution_option="[height<=1080]"
    else
      resolution_option="[height<=$resolution]"
    fi

    if [[ "$video_type" == "default" ]]; then
      format_option="-f \"bestvideo$resolution_option+bestaudio/best\""
    else
      format_option="-f \"bestvideo$resolution_option[ext=$video_type]+bestaudio/best\""
    fi

    # Ask for subtitles (only for video)
    subtitle_option=$(echo -e "No\nYes" | fzf --header "4. Add Subtitles?" --reverse)

    if [[ "$subtitle_option" == "Yes" ]]; then
      subtitle_lang=$(echo -e "en\ntr" | fzf --header "Select Subtitle Language" --reverse)
      subtitle_option="--write-subs --sub-lang $subtitle_lang"
    else
      subtitle_option=""
    fi
  else
    download_location=~/Music
    # Choose audio format (default, mp3)
    audio_type=$(echo -e "default\nmp3" | fzf --header "2. Select Audio Format" --reverse)
    if [[ "$audio_type" == "default" ]]; then
      format_option="-f bestaudio"
    else
      format_option="-f bestaudio[ext=$audio_type]"
    fi
  fi

  # Prompt for the URL to download
  read "url?Enter the URL to download: "

  # Construct the command
  command="yt-dlp -o '$download_location/%(title)s.%(ext)s' $format_option"

  # Add subtitle option if available
  if [[ -n "$subtitle_option" ]]; then
    command="$command $subtitle_option"
  fi

  # Append the URL
  command="$command $url"

  # Execute the command without using eval
  echo "Executing command: $command"
  bash -c "$command"
}

# ======================== Todo ========================
# Alt + X: Mark selected task as complete
# Alt + N: Add a new task
# Alt + E: Edit the selected task
function td(){
  todo.sh ls | head -n -2 | fzf --header="alt-x: Mark as done | alt-n: Add new task | alt-e: Edit task" --bind 'alt-x:execute(echo {} | cut -f1 -d" " | xargs todo.sh do)+reload(todo.sh ls | head -n -2),alt-n:execute(N=""; vared N; todo.sh add "$N")+reload(todo.sh ls | head -n -2),alt-e:execute(L=`echo {} | cut -d" " -f1`; E=`echo {} | cut -d" " -f2-`; vared E; sed -i "${TODO_FILE}" -e "${L}c\\${E}")+reload(todo.sh ls | head -n -2)' --reverse --height=40%;
}

# ======================== Yazi ========================
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

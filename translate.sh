#!/bin/bash
SOURCE_LANG="en"
TARGET_LANG="es"
LAST_TRANSLATION_FILE="/tmp/last_translation.txt"

urlencode() {
    local string="$1"
    echo -n "$string" | jq -sRr @uri
}

speak_text() {
    local text="$1"
    local encoded_text=$(urlencode "$text")
    local audio_url="https://translate.google.com/translate_tts?ie=UTF-8&tl=${SOURCE_LANG}&client=tw-ob&q=${encoded_text}"
    mpv "$audio_url" >/dev/null 2>&1
}

translate() {
    local text=$(xsel -o)
    local encoded_text=$(urlencode "$text")
    local url="https://translate.google.com/translate_a/single?client=gtx&sl=${SOURCE_LANG}&tl=${TARGET_LANG}&dt=t&q=${encoded_text}"
    local translation=$(curl -s "$url" | jq -r '.[0][] | .[0]' | tr -d '\n' | sed 's/null//g')
    echo "$text" > "$LAST_TRANSLATION_FILE"

    if [ "$(gsettings get org.gnome.desktop.interface color-scheme)" = "'prefer-dark'" ]; then
        GTK_THEME="Adwaita:dark"
    else
        GTK_THEME="Adwaita:light"
    fi

    export GTK_THEME

    SCREEN_WIDTH=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
    WINDOW_WIDTH=300
    WINDOW_X=$((($SCREEN_WIDTH - $WINDOW_WIDTH) / 2))

    response=$(zenity --info \
        --title="Traducción" \
        --text="$translation" \
        --ok-label="Cerrar" \
        --extra-button="Escuchar" \
        --timeout=10 \
        --width=$WINDOW_WIDTH \
        --window-icon="info" \
        2>/dev/null)

    if [ "$response" = "Escuchar" ]; then
        speak_text "$text"
    fi
}

translate

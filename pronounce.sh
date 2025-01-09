#!/bin/bash
SOURCE_LANG="en"
TARGET_LANG="en"

urlencode() {
    local string="$1"
    echo -n "$string" | jq -sRr @uri
}

speak_text() {
    local text=$(xsel -o)
    local encoded_text=$(urlencode "$text")
    local audio_url="https://translate.google.com/translate_tts?ie=UTF-8&tl=${SOURCE_LANG}&client=tw-ob&q=${encoded_text}"
    mpv "$audio_url" >/dev/null 2>&1
}

speak_text

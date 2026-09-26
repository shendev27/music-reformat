#!/bin/bash

# Usage: ./resize_embedded_art.sh

find . -type f -name "*.m4a" -print0 | while IFS= read -r -d '' file; do
    echo "Checking: $file"
    
    if ffprobe -v error -select_streams v:0 -show_entries stream=index -of csv=p=0 "$file" | grep -q '[0-9]'; then
        ffmpeg -y -i "$file" -vf "crop='min(iw,ih)':'min(iw,ih)',scale=500:500,format=yuv420p" -frames:v 1 /tmp/temp_art.jpg -loglevel error
        
        if [ -f /tmp/temp_art.jpg ]; then
            ffmpeg -y -i "$file" -i /tmp/temp_art.jpg -map 0:a -map 1:v -c:a copy -c:v copy -disposition:v attached_pic temp_fixed.m4a -loglevel error
            mv temp_fixed.m4a "$file"
            rm -f /tmp/temp_art.jpg
            echo "Fixed artwork: $file"
        fi
    else
        echo "No embedded artwork found: $file"
    fi
done
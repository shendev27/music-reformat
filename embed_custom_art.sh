#!/bin/bash

# Usage: ./embed_custom_art.sh /path/to/image.jpg

if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_image>"
    exit 1
fi

IMAGE_INPUT="$1"

if [ ! -f "$IMAGE_INPUT" ]; then
    echo "Error: Image file '$IMAGE_INPUT' not found."
    exit 1
fi

echo "Processing image '$IMAGE_INPUT'..."
ffmpeg -y -i "$IMAGE_INPUT" -vf "crop='min(iw,ih)':'min(iw,ih)',scale=500:500,format=yuv420p" -frames:v 1 /tmp/temp_art.jpg -loglevel error

if [ ! -f /tmp/temp_art.jpg ]; then
    echo "Error: Failed to process image with FFmpeg."
    exit 1
fi

find . -type f -name "*.m4a" -print0 | while IFS= read -r -d '' file; do
    echo "Applying art to: $file"
    ffmpeg -y -i "$file" -i /tmp/temp_art.jpg -map 0:a -map 1:v -c:a copy -c:v copy -disposition:v attached_pic temp_fixed.m4a -loglevel error
    
    if [ -f temp_fixed.m4a ]; then
        mv temp_fixed.m4a "$file"
        echo "Updated: $file"
    else
        echo "Failed: $file"
    fi
done

rm -f /tmp/temp_art.jpg
echo "Done."
# music-reformat

> **Got an older car with a touchscreen display, but no Apple CarPlay or Android Auto...?** 

If your car relies on standard USB audio playback, you've likely run into annoying display bugs: missing or distorted album art, stretched images, or tracks failing to render properly on the head unit.

**music-reformat** provides a set of lightweight, lossless Bash scripts to sanitize, resize, and format your local music library so it plays flawlessly on legacy vehicle audio systems.

---

## What These Scripts Do

Car head units from the 2010s often have strict hardware limitations regarding embedded image resolutions, file formats, and color encoding. These scripts automatically handle the heavy lifting using `ffmpeg`:

- **Album Art Optimization:** Scales artwork to standard **500x500 square JPEGs** using the **YUV 4:2:0 baseline color profile (`yuv420p`)**, ensuring broad compatibility with legacy displays.
- **Custom Artwork Batching:** Allows you to attach a custom image file across entire folders or albums in a single command.
- **Lossless Processing:** All metadata and cover art operations run with stream copying (`-c:a copy`), preserving 100% of your original audio quality without long re-encoding times.

---

## Requirements

These scripts require `ffmpeg` and `ffprobe` installed on your system.

### Installation

**Fedora / RHEL:**
```bash
sudo dnf install ffmpeg

**Ubuntu / Debian:**
```bash
sudo apt update && sudo apt install ffmpeg
```

**macOS (via Homebrew):**
```bash
brew install ffmpeg
```

---

### 1. Embed Custom Artwork (`embed_custom_art.sh`)
Pass any image file (PNG, JPG, WEBP, etc.) as an argument. The script automatically crops it to a square, resizes it to 500x500 YUV420p JPEG, and embeds it into every `.m4a` file in the current directory tree.

```bash
./embed_custom_art.sh /path/to/cover.jpg
```

### 2. Fix & Resize Existing Artwork (`resize_embedded_art.sh`)
Scans all `.m4a` files in your current folder, extracts the existing embedded cover art, converts it to a compatible 500x500 YUV420p JPEG, and re-embeds it without altering the original audio stream.

```bash
./resize_embedded_art.sh
```

---

## How It Works

Legacy vehicle head units often fail to display album art due to two main reasons:

1. **Excessive Image Dimensions:** High-resolution embedded artwork (e.g., 3000x3000px) exceeds head unit RAM/memory buffer limits.
2. **Unsupported Color Profiles:** Modern art using PNG compression or CMYK/YUV444 JPEG profiles won't render on legacy hardware decoders.

By enforcing a 1:1 aspect ratio, `500x500` pixel grid, and `yuv420p` pixel formatting, these scripts ensure your car screen renders album art reliably on every track.

---
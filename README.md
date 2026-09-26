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
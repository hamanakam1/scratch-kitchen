"""Assemble the generated illustration sources into the README's old-TV GIF.

Requires Pillow. Run from any directory with Python 3. Override STORYBOARD_FONT
and STORYBOARD_BOLD_FONT when the default macOS fonts are unavailable.
"""

import json
import os
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont, ImageOps

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "docs/storyboard"
SOURCE = OUT / "source"
FONT = os.environ.get("STORYBOARD_FONT", "/System/Library/Fonts/Supplemental/Arial.ttf")
BOLD = os.environ.get("STORYBOARD_BOLD_FONT", "/System/Library/Fonts/Supplemental/Arial Bold.ttf")
STEPS = [
    ("Scan your kitchen", "Record the freezer, fridge and pantry.", "Use photos for labels and close-ups."),
    ("Review what you have", "Confirm ingredients and use-first priorities.", "Unclear items stay flagged for review."),
    ("Cook a meal that fits", "Choose a meal for a person and a time.", "Use ingredients actually on hand."),
    ("Make something new", "Roast chicken becomes chicken soup.", "Reuse ingredients in a different meal."),
    ("Approve the extra", "Pack, label and approve this specific batch.", "Keep food and allergen details visible."),
    ("Share with a person", "Give away the extra through a human handoff.", "Cottage sales need a separate compliance check."),
]
SIZE = (1100, 733)
SCREEN = (116, 123, 1165, 836)
CREAM = (249, 240, 216)
INK = (39, 42, 32)
SAGE = (108, 139, 99)


def font(size, bold=False):
    return ImageFont.truetype(BOLD if bold else FONT, size)


def television(scene, step, zoom=1.0):
    tv = Image.open(SOURCE / "television.webp").convert("RGB")
    x0, y0, x1, y1 = SCREEN
    width, height = x1 - x0, y1 - y0
    # A narrow editorial sidebar keeps captions readable and leaves the whole
    # illustrated action visible in the square portion of the television screen.
    sidebar = 352
    art = ImageOps.fit(scene, (int((width - sidebar) * zoom), int(height * zoom)))
    left, top = (art.width - (width - sidebar)) // 2, (art.height - height) // 2
    art = art.crop((left, top, left + width - sidebar, top + height))
    screen = Image.new("RGB", (width, height), INK)
    screen.paste(art, (sidebar, 0))
    draw = ImageDraw.Draw(screen)
    draw.text((31, 39), "SCRATCH KITCHEN", font=font(21, True), fill=CREAM)
    draw.text((31, 88), f"{step + 1:02d} / 06", font=font(25), fill=(185, 199, 160))

    def text_block(text, y, size, bold=False, color=CREAM):
        words, line = text.split(), ""
        lines = []
        for word in words:
            candidate = (line + " " + word).strip()
            if draw.textlength(candidate, font=font(size, bold)) > sidebar - 62 and line:
                lines.append(line)
                line = word
            else:
                line = candidate
        lines.append(line)
        for line in lines:
            draw.text((31, y), line, font=font(size, bold), fill=color)
            y += int(size * 1.3)
        return y

    text_block(STEPS[step][0], 159, 42, True)
    caption_end = text_block(STEPS[step][1], 345, 26, True)
    text_block(STEPS[step][2], caption_end + 26, 25, color=(219, 218, 198))
    for n in range(6):
        start = 31 + n * 49
        draw.rounded_rectangle((start, height - 48, start + 38, height - 40), radius=4,
                               fill=(183, 202, 156) if n == step else (75, 79, 64))
    mask = Image.new("L", screen.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, width - 1, height - 1), radius=85, fill=255)
    tv.paste(screen, (x0, y0), mask)
    return tv.resize(SIZE, Image.Resampling.LANCZOS)


def main():
    sheet = Image.open(SOURCE / "scenes.webp").convert("RGB")
    assert sheet.size == (1536, 1024), sheet.size
    scenes = [sheet.crop((col * 512, row * 512, (col + 1) * 512, (row + 1) * 512))
              for row in range(2) for col in range(3)]
    frames, durations = [], []
    posters = []
    for step, scene in enumerate(scenes):
        posters.append(television(scene, step))
        for zoom in (1.0, 1.012, 1.024):
            frames.append(television(scene, step, zoom))
            durations.append(1500)
    # A global palette keeps the wooden cabinet stable across all frames.
    palette_sample = Image.new("RGB", (550 * 3, 367 * 2))
    for i, poster in enumerate(posters):
        palette_sample.paste(poster.resize((550, 367)), ((i % 3) * 550, (i // 3) * 367))
    palette = palette_sample.quantize(colors=192, method=Image.Quantize.MEDIANCUT)
    indexed = [f.quantize(palette=palette, dither=Image.Dither.NONE) for f in frames]
    indexed[0].save(OUT / "scratch-kitchen-tv.gif", save_all=True, append_images=indexed[1:],
                    duration=durations, loop=0, optimize=True, disposal=1)
    posters[0].save(OUT / "scratch-kitchen-tv-poster.png", optimize=True)
    still = Image.new("RGB", (1650, 734), CREAM)
    for i, poster in enumerate(posters):
        still.paste(poster.resize((550, 367)), ((i % 3) * 550, (i // 3) * 367))
    still.save(OUT / "scratch-kitchen-storyboard.png", optimize=True)
    gif = Image.open(OUT / "scratch-kitchen-tv.gif")
    actual_durations = []
    for i in range(gif.n_frames):
        gif.seek(i)
        actual_durations.append(gif.info["duration"])
    assert gif.is_animated and gif.info.get("loop") == 0
    assert gif.size == SIZE and sum(actual_durations) == 27000
    assert (OUT / "scratch-kitchen-tv.gif").stat().st_size < 5 * 1024 * 1024
    report = {"size": SIZE, "frames": gif.n_frames, "duration_ms": sum(actual_durations),
              "loop": "forever", "bytes": (OUT / "scratch-kitchen-tv.gif").stat().st_size,
              "generation": "Built-in image_gen illustrations; Pillow animation assembly",
              "scenes": [step[0] for step in STEPS]}
    (OUT / "build.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()

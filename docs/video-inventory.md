# Video Inventory — Video First, Photos as an Option

## Principle

Taking pictures item by item is way too slow. Video is the primary way in.
Photos stay as an option — a close-up, a single new item, or a fix for
something the video could not identify — but photographing the whole
kitchen one item at a time is not the workflow.

## Recording a walkthrough

- One continuous video per location: freezer, fridge, pantry, in that order.
- Slow pan, top shelf to bottom, no fast cuts, no shaky jump-cuts.
- Labels facing the camera where possible. Pause briefly on crowded shelves.
- 30–60 seconds per location is usually enough. A walkthrough beats 30 photos.
- Speak the item if you want — voice notes are an optional extra source, never required, and never replace the visual record.

## How the app reads a video

1. Extract frames at regular intervals (1 frame per second, plus a frame whenever the scene changes materially).
2. Identify items from those frames, on-device first. No cloud upload without explicit approval.
3. Track the same item across frames by location + appearance. An item seen in 10 frames is counted once, not 10 times. A later frame only updates quantity or still-good judgement, it never creates a duplicate.
4. Record source for every item: video file, timestamp (e.g. `freezer_walkthrough.mp4 @ 00:23`), and the best frame for that item.
5. Flag, don't guess: anything unclear from video is flagged for a still photo, not invented.

## Photos, as an option

- One item, one label, one new grocery bag coming in.
- A close-up to resolve a flagged video item.
- Same inventory fields, same ranking, same history as video items.
- Photos and video feed the same inventory. They are not two separate systems.

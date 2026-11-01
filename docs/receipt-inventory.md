# Receipt Inventory — Smart Deduplication

## Principle

You can photograph a receipt — or any document, list, or label — and the
system must be smart enough to know whether that receipt's items were
already inventoried from a video or a photo. A receipt must never blindly
double your inventory.

## How a receipt is read

1. Photograph the receipt (or upload a receipt image / PDF). The app reads
   the store, date, and line items: item name, quantity, price (price is
   recorded, but price never creates an inventory item on its own).
2. Each receipt line is matched against the existing inventory, in this order:
   - Exact / near-exact name match, same location (freezer / fridge / pantry),
     within a sensible time window (same shopping trip, same day).
   - Same product, different wording (e.g. "chicken breast" vs "chkn brst"):
     normalised name match, flagged as a probable match, not auto-merged
     without a confidence rule (see below).
   - No match: a genuinely new item, added to inventory, marked
     `source: receipt`, with the receipt photo as its source.
3. Outcomes per line, always shown, never silent:
   - `already_inventoried` — item already in inventory from video/photo.
     No duplicate created. Quantity is only updated if the receipt shows
     more than inventory, and that update is logged as a version, not a silent edit.
   - `probable_match` — likely the same item, wording differs. Shown for
     confirmation. Not merged until confirmed (by the cook, or by a high-confidence rule recorded in the app).
   - `new_item` — not in inventory. Added, with receipt as source.
   - `conflict` — receipt says one quantity, video/photo says another, or
     receipt date is after the item was already used. Flagged, not resolved
     by guessing. The cook resolves it, and the resolution is logged.
4. A receipt line is never treated as proof an item is still on hand if a
   later video shows it gone, or a later meal used it up. The most recent
   visual / meal record wins for "on hand" status; the receipt stays in
   history as the purchase record.

## "Or whatever"

The same rule applies to any document, not just receipts: a shopping list,
a delivery confirmation, a pantry list, a label photo. Read it, match it
against what is already inventoried, add only what is new, flag conflicts,
never duplicate silently.

## What a receipt does NOT do

- It does not override a video. If the video shows 1 chicken and the receipt
  shows 2, that is a conflict to flag, not a quantity to auto-correct to 2.
- It does not create a meal, a share, or a shopping trip on its own.
- It does not invent a location. If the receipt does not say freezer vs
  fridge, location is inferred only from the item type + a later video/photo,
  otherwise it is left blank and flagged.

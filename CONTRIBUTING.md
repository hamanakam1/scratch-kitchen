# Contributing to Scratch Kitchen

Scratch Kitchen is open source (MIT). Contributions are welcome — code, docs, meal rules, share-board improvements, and real kitchen testing.

## Principles, non-negotiable

1. **No invented data.** No invented inventory, preferences, allergies, or recipients. An item not in inventory is not in a meal.
2. **Reuse, not leftovers.** An ingredient may be reused into a new meal. A served meal may not be re-served as the same meal. Name every transformation.
3. **No share without approval.** No send, sale, delivery, or contact without the cook's specific approval for that specific meal, batch, or offer.
4. **Local-first.** No kitchen photo is sent to a cloud service for recognition without explicit approval. On-device first.
5. **No silent edits.** Corrections are new versions. History is the audit trail for what was used, shared, or wasted.
6. **Small, simple, clear.** Meal descriptions ≤ 40 words. Portions small and simple. UI that a household member can glance at and understand.

## How to contribute

1. Fork the repo, create a branch for one change.
2. Keep the change small and focused — one rule, one screen, one module.
3. Add or update tests for core rules (use-first ranking, reuse transformation, share-board state machine).
4. Update the docs for any rule you change — README, `docs/spec.md`, and the affected module docs, in the same change.
5. Open a pull request describing: what changed, why, what kitchen test you ran (real photos, real inventory, or a named test fixture), and what is still untested.

## What not to contribute

- Automatic dispatch, payment, or courier booking (out of v1 scope).
- Food-safety claims, certifications, or guarantees. Still-good judgements are the cook's judgement, not a guarantee.
- Legal advice about cottage food law. Compliance checks must cite an official source, and be recorded as a check, not as advice.
- Any feature that sends, sells, or delivers food without approval, or that contacts a charity, neighbour, or delivery service automatically.

## Kitchen testing

The best test is a real one: photograph a freezer shelf, inventory it, propose a day's meals from it, cook one, update inventory, and flag the extra. Report what the app got wrong — a mis-identified item, a bad rank, a meal that could not be ready on time — as an issue, with the photo batch date and location.

## Code style

- Elixir: follow `mix format`, keep modules small, pattern-match on the happy and the flagged paths, never on an assumed value.
- Swift: SwiftUI, declarative, one view per screen (photo in, inventory, today's meals, share board), no UIKit unless a camera feature genuinely needs it.

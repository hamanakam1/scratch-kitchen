# Architecture

SwiftUI is the camera face (iPhone / Mac): photos, on-device Vision, meal cards, Live Activities for ready times.
Elixir / BEAM is the coordination heart: inventory ranking, meal proposals, share-board state, timers.
A failing process (one timer, one offer) must not take down the rest — supervision trees, not a monolith crash.

Alternative cores: Rust for the deterministic meal engine, Nim for a fast local-first prototype. The SwiftUI face stays the same.
Local-first by default. No cloud photo upload without explicit approval.

import SwiftUI

// Scratch Kitchen — SwiftUI camera face, sketch.
// Photo in (camera, on-device Vision first, no cloud upload without approval),
// Inventory (use-first ranked), Today's meals (specific time, specific person),
// Share board (planned -> packed -> offered -> picked up -> delivered).
// This is a UI sketch, not a compiled app yet. Build on a Mac with Xcode.

struct ContentView: View {
    var body: some View {
        TabView {
            VideoInView().tabItem { Label("Video in", systemImage: "video") }
            PhotoInView().tabItem { Label("Photo", systemImage: "camera") }
            ReceiptInView().tabItem { Label("Receipt", systemImage: "doc.text") }
            InventoryView().tabItem { Label("Inventory", systemImage: "list.clipboard") }
            TodaysMealsView().tabItem { Label("Today's meals", systemImage: "fork.knife") }
            ShareBoardView().tabItem { Label("Share", systemImage: "heart") }
        }
    }
}

struct VideoInView: View {
    var body: some View {
        Text("Video first: slow walkthrough, freezer → fridge → pantry.\nOne video beats 30 photos. Same item in many frames = counted once.")
            .multilineTextAlignment(.center)
    }
}

struct PhotoInView: View {
    var body: some View {
        Text("Photo, as an option: one item, one label, or a close-up\nto fix something the video could not identify.")
            .multilineTextAlignment(.center)
    }
}

struct ReceiptInView: View {
    var body: some View {
        Text("Photograph a receipt or list. Lines are matched against\ninventory: already inventoried, probable match, new item, or conflict.\nNo silent duplicates.")
            .multilineTextAlignment(.center)
    }
}

struct InventoryView: View {
    var body: some View { Text("Inventory, sorted by use-first rank. Rank 1 = use first.") }
}

struct TodaysMealsView: View {
    var body: some View { Text("Specific meal, ready at a specific time, for a specific person, from inventory only.") }
}

struct ShareBoardView: View {
    var body: some View { Text("Share board: planned → packed → offered → picked up → delivered. Giveaway vs cottage sale, clearly labelled.") }
}

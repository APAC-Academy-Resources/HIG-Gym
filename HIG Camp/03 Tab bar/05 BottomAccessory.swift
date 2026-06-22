import SwiftUI

/// Demonstrates `tabViewBottomAccessory` — a persistent control the system places
/// above the floating tab bar (the canonical example being Music's MiniPlayer).
///
/// When the tab bar is full size the accessory renders *above* it (`.expanded`);
/// when the tab bar minimizes on scroll it moves *inline* into the tab bar (`.inline`).
/// Read `\.tabViewBottomAccessoryPlacement` inside the accessory to adapt the layout.
struct TabViewBottomAccessoryDemoView: View {
    // MARK: - Variant
    enum Variant {
        case basic
        case adaptive
        case adaptiveWithSearch
    }

    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Tab View Bottom Accessory",
        description: "A persistent control above the tab bar (like Music's MiniPlayer). Scroll down — as the tab bar minimizes the accessory moves inline into it.",
        systemImage: "play.square.stack"
    )

    // MARK: - Properties & Methods
    @State private var isEnabled = true

    // MARK: - Body
    var body: some View {
        switch variant {
        case .basic:
            tabs
                .tabViewBottomAccessory {
                    AdaptiveNowPlayingAccessory()
                }
        case .adaptive, .adaptiveWithSearch:
            tabs
                .tabBarMinimizeBehavior(.onScrollDown) // collapsing flips placement to .inline
                .tabViewBottomAccessory {
                    AdaptiveNowPlayingAccessory()
                }
        }
    }

    // MARK: - View Components
    private var tabs: some View {
        TabView {
            Tab("Play", systemImage: "guitars") {
                content(title: "Play", count: 30)
            }
            Tab("Browse", systemImage: "square.grid.2x2") {
                content(title: "Browse", count: 30)
            }
            Tab("Record", systemImage: "microphone") {
                content(title: "Record", count: 20)
            }
            if variant == .adaptiveWithSearch {
                Tab("Search", systemImage: "magnifyingglass", role: .search) {
                    content(title: "Search", count: 15)
                }
            }
        }
    }

    private func content(title: String, count: Int) -> some View {
        NavigationStack {
            DemoScrollView(count: count)
                .navigationTitle(title)
                .toolbarTitleDisplayMode(.inlineLarge)
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                .safeAreaBar(edge: .top) {
                    infoCard
                        .padding(.horizontal)
                }
        }
    }
}

/// A mini-player that adapts to the tab bar's accessory placement:
/// compact when `.inline` (collapsed into the tab bar), rich when `.expanded`.
private struct AdaptiveNowPlayingAccessory: View {
    @Environment(\.tabViewBottomAccessoryPlacement) private var placement

    var body: some View {
        switch placement {
        case .inline:
            HStack {
                Image(systemName: "music.note")
                Text("Aurora")
                    .font(.subheadline)
                    .lineLimit(1)
                Spacer()
                Button("Pause", systemImage: "pause.fill") { }
                    .labelStyle(.iconOnly)
            }
            .padding(.horizontal)

        case .expanded:
            HStack(spacing: 16) {
                Image(systemName: "music.note")
                    .font(.title3)
                VStack(alignment: .leading, spacing: 1) {
                    Text("Aurora")
                        .font(.subheadline.weight(.semibold))
                    Text("Sunrise Sessions")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button("Back", systemImage: "backward.fill") { }
                Button("Pause", systemImage: "pause.fill") { }
                Button("Next", systemImage: "forward.fill") { }
            }
            .labelStyle(.iconOnly)
            .padding(.horizontal)

        default: // placement is optional — nil means undefined
            EmptyView()
        }
    }
}

#Preview("Basic") {
    TabViewBottomAccessoryDemoView(variant: .basic)
        .tint(.purple)
}

#Preview("Adaptive (scroll down to collapse)") {
    TabViewBottomAccessoryDemoView(variant: .adaptive)
        .tint(.purple)
}

#Preview("Adaptive with search") {
    TabViewBottomAccessoryDemoView(variant: .adaptiveWithSearch)
        .tint(.purple)
}

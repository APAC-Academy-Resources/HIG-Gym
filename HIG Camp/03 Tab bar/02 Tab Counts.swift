import SwiftUI

struct TabCountsDemoView: View {
    // MARK: - Variant
    enum Variant {
        case two
        case twoMinimize
        case four
        case six
        case sixMinimize
    }

    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Tab Count & Layout",
        description: "2–6 tabs in the floating bar. With more tabs the bar widens; pair with minimize-on-scroll to reclaim space. Scroll down to see it collapse.",
        systemImage: "square.grid.3x1.below.line.grid.1x2"
    )

    // MARK: - Body
    var body: some View {
        switch variant {
        case .two:
            twoTabs
        case .twoMinimize:
            twoTabs.tabBarMinimizeBehavior(.onScrollDown)
        case .four:
            fourTabs
        case .six:
            sixTabs
        case .sixMinimize:
            sixTabs.tabBarMinimizeBehavior(.onScrollDown)
        }
    }

    // MARK: - View Components

    private var twoTabs: some View {
        TabView {
            Tab("Home", systemImage: "house") { homeContent }
            Tab("Settings", systemImage: "gearshape") { settingsContent }
        }
    }

    private var fourTabs: some View {
        TabView {
            Tab("Home", systemImage: "house") { homeContent }
            Tab("Browse", systemImage: "square.grid.2x2") { browseContent }
            Tab("Favorites", systemImage: "star") { favoritesContent }
            Tab("Settings", systemImage: "gearshape") { settingsContent }
        }
    }

    private var sixTabs: some View {
        TabView {
            Tab("Home", systemImage: "house") { homeContent }
            Tab("Browse", systemImage: "square.grid.2x2") { browseContent }
            Tab("Favorites", systemImage: "star") { favoritesContent }
            Tab("Inbox", systemImage: "tray") { inboxContent }
            Tab("Profile", systemImage: "person") { profileContent }
            Tab("Settings", systemImage: "gearshape") { settingsContent }
        }
    }

    private var homeContent: some View {
        NavigationStack {
            DemoScrollView(count: 20)
                .background(Color(.tintColor).gradient.opacity(0.7))
                .navigationTitle("Home")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                .safeAreaBar(edge: .bottom) {
                    infoCard
                        .padding(.horizontal)
                }
        }
    }

    private var browseContent: some View {
        NavigationStack {
            DemoScrollView(count: 25)
                .navigationTitle("Browse")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }

    private var favoritesContent: some View {
        NavigationStack {
            DemoScrollView(count: 12)
                .background(Color(.tintColor).gradient.opacity(0.7))
                .toolbarTitleDisplayMode(.inline)
                .navigationTitle("Favorites")
                .toolbarTitleMenu {
                    Text("test")
                }
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }

    private var inboxContent: some View {
        NavigationStack {
            DemoScrollView(count: 18)
                .background(Color(.tintColor).gradient.opacity(0.7))
                .navigationTitle("Inbox")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }

    private var profileContent: some View {
        NavigationStack {
            DemoScrollView(count: 10)
                .background(Color(.tintColor).gradient.opacity(0.7))
                .navigationTitle("Profile")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }

    private var settingsContent: some View {
        NavigationStack {
            DemoScrollView(count: 8)
                .background(Color(.tintColor).gradient.opacity(0.7))
                .navigationTitle("Settings")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
        }
    }
}

#Preview("Two Tabs") {
    TabCountsDemoView(variant: .two)
        .tint(.gray)
}

#Preview("Two Tabs + Minimize Behavior") {
    TabCountsDemoView(variant: .twoMinimize)
        .tint(.gray)
}

#Preview("Four Tabs") {
    TabCountsDemoView(variant: .four)
        .tint(.gray)
}

#Preview("Six Tabs") {
    TabCountsDemoView(variant: .six)
        .tint(.gray)
}

#Preview("Six Tabs + Minimize Behavior") {
    TabCountsDemoView(variant: .sixMinimize)
        .tint(.gray)
}

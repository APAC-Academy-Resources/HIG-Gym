//
//  02 Tab Counts.swift
//  HIG Camp
//

import SwiftUI

struct TabCountsDemo: View {
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

    // MARK: - State
    private let tint: Color = .gray

    // MARK: - Body
    var body: some View {
        tabView
            .tint(tint)
    }

    // MARK: - View Components
    @ViewBuilder
    private var tabView: some View {
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

    private var twoTabs: some View {
        TabView {
            Tab("Home", systemImage: "house") { tabContent(title: "Home", count: 20) }
            Tab("Settings", systemImage: "gearshape") { tabContent(title: "Settings", count: 8) }
        }
    }

    private var fourTabs: some View {
        TabView {
            Tab("Home", systemImage: "house") { tabContent(title: "Home", count: 20) }
            Tab("Browse", systemImage: "square.grid.2x2") { tabContent(title: "Browse", count: 25) }
            Tab("Favorites", systemImage: "star") { tabContent(title: "Favorites", count: 12) }
            Tab("Settings", systemImage: "gearshape") { tabContent(title: "Settings", count: 8) }
        }
    }

    private var sixTabs: some View {
        TabView {
            Tab("Home", systemImage: "house") { tabContent(title: "Home", count: 20) }
            Tab("Browse", systemImage: "square.grid.2x2") { tabContent(title: "Browse", count: 25) }
            Tab("Favorites", systemImage: "star") { tabContent(title: "Favorites", count: 12) }
            Tab("Inbox", systemImage: "tray") { tabContent(title: "Inbox", count: 18) }
            Tab("Profile", systemImage: "person") { tabContent(title: "Profile", count: 10) }
            Tab("Settings", systemImage: "gearshape") { tabContent(title: "Settings", count: 8) }
        }
    }

    /// Filler for one tab. Chrome, not the taught API — every tab looks the same
    /// so the only thing that changes between variants is the number of tabs.
    private func tabContent(title: String, count: Int) -> some View {
        NavigationStack {
            DemoScrollView(count: count)
                .background(Color(.tintColor).gradient.opacity(0.7))
                .navigationTitle(title)
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                .safeAreaBar(edge: .bottom) {
                    infoCard
                        .padding()
                }
        }
    }
}

#Preview("Two Tabs") {
    TabCountsDemo(variant: .two)
}

#Preview("Two Tabs + Minimize Behavior") {
    TabCountsDemo(variant: .twoMinimize)
}

#Preview("Four Tabs") {
    TabCountsDemo(variant: .four)
}

#Preview("Six Tabs") {
    TabCountsDemo(variant: .six)
}

#Preview("Six Tabs + Minimize Behavior") {
    TabCountsDemo(variant: .sixMinimize)
}

//
//  07 Minimize Behavior.swift
//  HIG Camp
//

import SwiftUI

struct MinimizeBehaviorDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Tab Bar Minimize Behavior",
        description: "Controls when the floating tab bar shrinks: never, on scroll down, or on scroll up. Scroll the list to trigger it.",
        systemImage: "arrow.down.right.and.arrow.up.left"
    )

    // MARK: - State
    /// The axis this demo varies. A system type rather than a nested `Variant`,
    /// since `TabBarMinimizeBehavior` already enumerates exactly the cases taught.
    let behavior: TabBarMinimizeBehavior

    // MARK: - Body
    //
    // No single `.tint` on the type: each tab deliberately carries its own colour
    // so you can tell which tab you scrolled in as the bar collapses.
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                content(title: "Home", color: .blue, count: 30)
            }
            Tab("Browse", systemImage: "square.grid.2x2") {
                content(title: "Browse", color: .purple, count: 30)
            }
            Tab("Favorites", systemImage: "star") {
                content(title: "Favorites", color: .orange, count: 30)
            }
            Tab("Settings", systemImage: "gearshape") {
                content(title: "Settings", color: .gray, count: 30)
            }
        }
        .tabBarMinimizeBehavior(behavior)
    }

    // MARK: - View Components
    private func content(title: String, color: Color, count: Int) -> some View {
        NavigationStack {
            DemoScrollView(count: count)
                .tint(color)
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

#Preview("Never") {
    MinimizeBehaviorDemo(behavior: .never)
}

#Preview("On Scroll Down") {
    MinimizeBehaviorDemo(behavior: .onScrollDown)
}

#Preview("On Scroll Up") {
    MinimizeBehaviorDemo(behavior: .onScrollUp)
}

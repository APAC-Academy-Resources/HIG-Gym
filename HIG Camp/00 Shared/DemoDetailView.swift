//
//  DemoDetailView.swift
//  HIG Camp
//

import SwiftUI

/// A stand-in destination screen, used by the navigation demos.
///
/// Register it at the call site so each screen owns its own navigation:
/// ```swift
/// .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
/// ```
struct DemoDetailView: View {
    /// Shown as the navigation title.
    let item: String
    /// Explains what to watch for on this screen. Defaults to a note about
    /// toolbar item transitions, which is what most callers are demonstrating.
    var infoCard: DemoInfoCard? = DemoInfoCard(
        title: "Toolbar Transitions",
        description: "Notice how the toolbar items transitioned from the previous page to this page."
    )
    /// Whether pushing this screen hides the tab bar.
    var tabBarHiddenOnDetail: Bool = true

    var body: some View {
        ScrollView {
            if let infoCard {
                infoCard
            }
        }
        .contentMargins(DemoMetrics.pageMargin)
        .toolbarTitleDisplayMode(.inline)
        .navigationTitle(item)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Share", systemImage: "square.and.arrow.up") { }
                Button("Bookmark", systemImage: "bookmark") { }
                Button("More", systemImage: "ellipsis.circle") { }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Previous", systemImage: "chevron.left") { }
                Spacer()
                Button("Next", systemImage: "chevron.right") { }
            }
        }
        .toolbar(tabBarHiddenOnDetail ? .hidden : .visible, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        DemoDetailView(item: "Item 1")
    }
}

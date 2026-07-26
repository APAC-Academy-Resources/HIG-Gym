//
//  03 Visibility.swift
//  HIG Camp
//

import SwiftUI

struct TabVisibilityDemo: View {
    // MARK: - Variant
    enum Variant {
        case alwaysVisible
        case hiddenOnDetail
    }

    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Tab Bar Visibility",
        description: "Push a detail view and watch the tab bar. \"Hidden on Detail\" drops it on deeper screens; \"Always Visible\" keeps it. Tap a row to push.",
        systemImage: "rectangle.bottomthird.inset.filled"
    )

    // MARK: - Body
    //
    // No tint on the type: visibility is the subject, and the system accent keeps
    // the eye on where the bar is rather than what colour it is.
    var body: some View {
        TabView {
            Tab("Browse", systemImage: "list.bullet") {
                tabContent(title: "Browse", count: 20, isPrimaryTab: true)
            }
            Tab("Favorites", systemImage: "star") {
                tabContent(title: "Favorites", count: 12)
            }
            Tab("Settings", systemImage: "gearshape") {
                tabContent(title: "Settings", count: 8)
            }
        }
    }

    // MARK: - View Components
    /// One tab's list. The `.navigationDestination` stays visible here because
    /// `tabBarHiddenOnDetail:` is the API being taught — the pushed detail is
    /// what decides whether the tab bar survives.
    ///
    /// - Parameter isPrimaryTab: The first tab also carries the info card and a
    ///   sample toolbar item; the other two are plain.
    private func tabContent(title: String, count: Int, isPrimaryTab: Bool = false) -> some View {
        NavigationStack {
            DemoScrollView(count: count)
                .navigationTitle(title)
                .navigationDestination(for: String.self) {
                    DemoDetailView(item: $0, tabBarHiddenOnDetail: variant == .hiddenOnDetail)
                }
                .toolbar {
                    if isPrimaryTab {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Star", systemImage: "star") { }
                        }
                    }
                }
                .safeAreaBar(edge: .bottom) {
                    if isPrimaryTab {
                        infoCard
                            .padding()
                    }
                }
        }
    }
}

#Preview("Always Visible") {
    TabVisibilityDemo(variant: .alwaysVisible)
}

#Preview("Hidden on Detail") {
    TabVisibilityDemo(variant: .hiddenOnDetail)
}

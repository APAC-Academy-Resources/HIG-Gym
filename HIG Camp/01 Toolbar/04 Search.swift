//
//  04 Search.swift
//  HIG Camp
//

import SwiftUI

struct ToolbarSearchDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Search bar placements",
        description: "The system can determine different search bar placements",
        systemImage: "magnifyingglass"
    )

    // MARK: - State
    let placement: SearchFieldPlacement
    var bottomItems: Bool = false
    /// Contacts-style: dock the search field in the bottom bar with a leading "+".
    var bottomSearch: Bool = false

    private let tint: Color = .green

    // MARK: - Body
    var body: some View {
        NavigationStack {
            DemoSearchView(placement: placement, prompt: "Search items")
                .background(.tint.secondary)
                .toolbarTitleDisplayMode(.inline)
                .navigationTitle("Search")
                .toolbar { toolbar }
                .safeAreaBar(edge: .bottom) {
                    infoCard.padding(.horizontal)
                }
        }
        .tint(tint)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Filter", systemImage: "line.3.horizontal.decrease") { }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Sort", systemImage: "arrow.up.arrow.down") { }
        }
        if bottomItems {
            ToolbarSpacer(placement: .bottomBar)
            ToolbarItem(placement: .bottomBar) {
                Button("Map", systemImage: "map") { }
            }
        }
        if bottomSearch {
            DefaultToolbarItem(
                kind: .search,
                placement: .bottomBar
            )
            ToolbarSpacer(
                .fixed,
                placement: .bottomBar
            )
            ToolbarItem(placement: .bottomBar) {
                Button(
                    "Add",
                    systemImage: "plus"
                ) { }
            }
        }
    }
}

#Preview("Toolbar") {
    ToolbarSearchDemo(placement: .toolbar)
}

#Preview("Toolbar + bottom items") {
    ToolbarSearchDemo(placement: .toolbar, bottomItems: true)
}

#Preview("Bottom search + custom items") {
    ToolbarSearchDemo(placement: .toolbar, bottomSearch: true)
}

#Preview("Drawer") {
    ToolbarSearchDemo(placement: .navigationBarDrawer)
}

#Preview("Drawer Always") {
    ToolbarSearchDemo(placement: .navigationBarDrawer(displayMode: .always))
}

#Preview("Toolbar Principal") {
    ToolbarSearchDemo(placement: .toolbarPrincipal)
}

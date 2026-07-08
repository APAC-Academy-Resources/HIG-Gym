import SwiftUI

struct ToolbarSearchDemoView: View {
    // MARK: - Properties & Methods
    let placement: SearchFieldPlacement
    var bottomItems: Bool = false
    /// Contacts-style: dock the search field in the bottom bar with a leading "+".
    var bottomSearch: Bool = false

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Search bar placements",
        description: "The system can determine different search bar placements",
        systemImage: "magnifyingglass"
    )

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
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
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
    ToolbarSearchDemoView(placement: .toolbar)
        .tint(.green)
}

#Preview("Toolbar + bottom items") {
    ToolbarSearchDemoView(placement: .toolbar, bottomItems: true)
        .tint(.green)
}

#Preview("Bottom search + custom items") {
    ToolbarSearchDemoView(placement: .toolbar, bottomSearch: true)
        .tint(.green)
}

#Preview("Drawer") {
    ToolbarSearchDemoView(placement: .navigationBarDrawer)
        .tint(.green)
}

#Preview("Drawer Always") {
    ToolbarSearchDemoView(placement: .navigationBarDrawer(displayMode: .always))
        .tint(.green)
}

#Preview("Toolbar Principal") {
    ToolbarSearchDemoView(placement: .toolbarPrincipal)
        .tint(.green)
}

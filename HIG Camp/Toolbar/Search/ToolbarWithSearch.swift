
import SwiftUI

struct ToolbarSearchDemoView: View {
    let placement: SearchFieldPlacement

    @State private var searchText = ""

    private let allItems = [
        "Accessibility", "Animation", "Color", "Controls", "Dark Mode",
        "Fonts", "Icons", "Layout", "Navigation", "Search",
        "Sheets", "Sidebars", "Tabs", "Toolbars", "Typography"
    ]

    private var filteredItems: [String] {
        searchText.isEmpty ? allItems : allItems.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        NavigationStack {
            List(filteredItems, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Search Demo")
            .toolbarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: placement, prompt: "Search items")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", systemImage: "plus") { }
                        .buttonStyle(.borderedProminent)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sort", systemImage: "arrow.up.arrow.down") { }
                }
            }
        }
    }
}

#Preview("Automatic") {
    ToolbarSearchDemoView(placement: .automatic)
}

#Preview("Drawer") {
    ToolbarSearchDemoView(placement: .navigationBarDrawer)
}

#Preview("Drawer Always") {
    ToolbarSearchDemoView(placement: .navigationBarDrawer(displayMode: .always))
}

#Preview("Toolbar Principal") {
    ToolbarSearchDemoView(placement: .toolbarPrincipal)
}

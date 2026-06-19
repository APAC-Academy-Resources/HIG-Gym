import SwiftUI

/// A searchable list of demo topics that filters live and navigates to `DemoDetailView`.
/// Shared across the search demos (toolbar search, tab-bar search).
///
/// Owns its own search state and registers `.searchable` + the navigation destination,
/// so wrap it in a `NavigationStack` and apply title/background/tint at the call site
/// — just like `DemoScrollView`.
struct DemoSearchView: View {
    var placement: SearchFieldPlacement = .automatic
    var prompt: String = "Search topics"

    @State private var searchText = ""

    private let allItems = [
        "Accessibility", "Animation", "Color", "Controls", "Dark Mode",
        "Fonts", "Icons", "Layout", "Navigation", "Search",
        "Sheets", "Sidebars", "Tabs", "Toolbars", "Typography"
    ]

    private var filteredItems: [String] {
        searchText.isEmpty
            ? allItems
            : allItems.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(filteredItems, id: \.self) { item in
                    NavigationLink(value: item) {
                        DemoRowView(label: item)
                    }
                }
            }
            .padding(.vertical)
        }
        .contentMargins(.horizontal, 16, for: .automatic)
        .searchable(text: $searchText, placement: placement, prompt: prompt)
        .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
    }
}

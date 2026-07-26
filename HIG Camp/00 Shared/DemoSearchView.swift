//
//  DemoSearchView.swift
//  HIG Camp
//

import SwiftUI

/// A searchable list of demo topics that filters live and navigates to
/// ``DemoDetailView``. Shared across the search demos (toolbar search,
/// tab-bar search).
///
/// Owns its own search state and registers `.searchable` plus the navigation
/// destination, so wrap it in a `NavigationStack` and apply the title at the
/// call site — just like ``DemoScrollView``.
struct DemoSearchView: View {
    /// Where the search field appears. The point of most search demos.
    var placement: SearchFieldPlacement = .automatic
    /// Placeholder text inside the search field.
    var prompt: String = "Search topics"
    /// Background wash behind the rows.
    var tint: Color = Color(.tintColor)

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
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical)
        }
        .background(tint.gradient.secondary)
        .contentMargins(.horizontal, DemoMetrics.pageMargin, for: .automatic)
        .searchable(
            text: $searchText,
            placement: placement,
            prompt: prompt
        )
        .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
    }
}

#Preview {
    NavigationStack {
        DemoSearchView()
            .navigationTitle("Search")
    }
}

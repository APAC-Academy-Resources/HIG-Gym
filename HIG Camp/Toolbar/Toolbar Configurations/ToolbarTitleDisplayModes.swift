import SwiftUI

// MARK: - List View

enum ToolbarItemsVariant {
    case leadingAndTrailing // items on both nav bar edges
    case itemGroup          // ToolbarItemGroup with three buttons
    case fiveItems          // five individual ToolbarItems
}

struct ToolbarTitleDemoView: View {
    let mode: ToolbarTitleDisplayMode
    var toolbarItems: ToolbarItemsVariant = .leadingAndTrailing

    var body: some View {
        NavigationStack {
            DemoScrollView(count: 20)
            .background(.cyan.gradient.opacity(0.7))
            .tint(.cyan)
            .navigationTitle("Toolbar Titles")
            .toolbarTitleDisplayMode(mode)
            .navigationDestination(for: String.self) { item in
                DemoDetailView(item: item)
            }
            .toolbar {
                switch toolbarItems {
                case .leadingAndTrailing:
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Page", systemImage: "text.page") { }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Filter", systemImage: "line.3.horizontal.decrease") { }
                    }
                case .itemGroup:
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Share", systemImage: "square.and.arrow.up") { }
                        Button("Bookmark", systemImage: "bookmark") { }
                        Button("More", systemImage: "ellipsis.circle") { }
                    }
                case .fiveItems:
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Search", systemImage: "magnifyingglass") { }
                        Button("Share", systemImage: "square.and.arrow.up") { }
                        Button("Bookmark", systemImage: "bookmark") { }
                        Button("Favourite", systemImage: "star") { }
                    }
                }
            }
        }
    }
}

// MARK: - Previews

#Preview("Large Title") {
    ToolbarTitleDemoView(mode: .large)
}

#Preview("Inline Large Title") {
    ToolbarTitleDemoView(mode: .inlineLarge)
}

#Preview("Inline Title") {
    ToolbarTitleDemoView(mode: .inline)
}

#Preview("Automatic") {
    ToolbarTitleDemoView(mode: .automatic)
}

#Preview("Leading + Trailing") {
    ToolbarTitleDemoView(mode: .inline, toolbarItems: .leadingAndTrailing)
}

#Preview("Five Items") {
    ToolbarTitleDemoView(mode: .inline, toolbarItems: .fiveItems)
}

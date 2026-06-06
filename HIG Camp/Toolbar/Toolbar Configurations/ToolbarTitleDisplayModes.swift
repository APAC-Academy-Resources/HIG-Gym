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

    private let items = (1...20).map { "Item \($0)" }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(value: item) {
                            DemoRow(label: item)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Toolbar Titles")
            .toolbarTitleDisplayMode(mode)
            .navigationDestination(for: String.self) { item in
                ToolbarDetailView(item: item)
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
            .background(.cyan.gradient.opacity(0.7))
        }
    }
}

// MARK: - Detail View

struct ToolbarDetailView: View {
    let item: String

    var body: some View {
        ScrollView {
            Text("Detail content for \(item)")
                .padding()
        }
        .navigationTitle(item)
        .toolbarTitleDisplayMode(.inline)
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

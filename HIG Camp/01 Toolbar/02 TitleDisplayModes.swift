import SwiftUI

// MARK: - List View

enum TitleDisplayModesVariant {
    case leadingAndTrailing
    case itemGroup
    case fiveItems
}

struct ToolbarTitleDisplayModesDemoView: View {
    let mode: ToolbarTitleDisplayMode
    var titleMenu: Bool = false
    var toolbarItems: TitleDisplayModesVariant = .leadingAndTrailing

    private var content: some View {
        DemoScrollView(count: 20)
            .toolbarTitleDisplayMode(mode)
            .navigationTitle("Toolbar Titles")
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
            .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
    }

    var body: some View {
        NavigationStack {
            if titleMenu {
                content
                    .toolbarTitleMenu {
                        Button("Rename", systemImage: "pencil") {}
                        Button("Delete", systemImage: "xmark.circle.fill", role: .destructive) {}
                    }
            } else {
                content
            }
        }
    }
}

// MARK: - Previews

#Preview("Large Title") {
    ToolbarTitleDisplayModesDemoView(mode: .large)
        .tint(.orange)
}

#Preview("Inline Large Title") {
    ToolbarTitleDisplayModesDemoView(mode: .inlineLarge)
        .tint(.orange)
}

#Preview("Inline Title") {
    ToolbarTitleDisplayModesDemoView(mode: .inline)
        .tint(.orange)
}

#Preview("Inline Title w/ Title Menu") {
    ToolbarTitleDisplayModesDemoView(mode: .inline, titleMenu: true)
        .tint(.orange)
}

#Preview("Automatic") {
    ToolbarTitleDisplayModesDemoView(mode: .automatic)
        .tint(.orange)
}

#Preview("Leading + Trailing") {
    ToolbarTitleDisplayModesDemoView(mode: .inline, toolbarItems: .leadingAndTrailing)
        .tint(.orange)
}

#Preview("Five Items") {
    ToolbarTitleDisplayModesDemoView(mode: .inline, toolbarItems: .fiveItems)
        .tint(.orange)
}

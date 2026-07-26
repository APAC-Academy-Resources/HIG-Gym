//
//  02 TitleDisplayModes.swift
//  HIG Camp
//

import SwiftUI

struct TitleDisplayModesDemo: View {
    // MARK: - Variant
    /// Which toolbar items accompany the title. Secondary to `mode` — the
    /// display mode is what this demo is really about.
    enum ToolbarItems {
        case leadingAndTrailing
        case itemGroup
        case fiveItems
        case customTitle
    }

    let mode: ToolbarTitleDisplayMode
    var titleMenu: Bool = false
    var toolbarItems: ToolbarItems = .leadingAndTrailing

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Toolbar Title Scroll Behavior",
        description: "Scroll down the list to observe how each title display mode adapts",
        systemImage: "character"
    )

    // MARK: - State
    private let tint: Color = .orange

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Group {
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
            .safeAreaBar(edge: .bottom) {
                infoCard
                    .padding(.horizontal)
            }
        }
        .tint(tint)
    }

    // MARK: - View Components
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
                case .customTitle:
                    ToolbarItem(placement: .largeTitle) {
                        HStack {
                            Image(systemName: "hands.sparkles.fill")
                                .padding(6)
                                .background(.regularMaterial)
                                .background(.indigo)
                                .foregroundStyle(.indigo)
                                .clipShape(.circle)
                            Text("Custom Large Title")
                                .fontDesign(.serif)
                                .foregroundStyle(.indigo)
                                .font(.largeTitle)
                            Spacer()
                        }
                        .padding(.top)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Page", systemImage: "text.page") { }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Filter", systemImage: "line.3.horizontal.decrease") { }
                    }
                }
            }
            .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
    }
}

#Preview("Large Title") {
    TitleDisplayModesDemo(mode: .large)
}

#Preview("Inline Large Title") {
    TitleDisplayModesDemo(mode: .inlineLarge)
}

#Preview("Inline Title") {
    TitleDisplayModesDemo(mode: .inline)
}

#Preview("Inline Title w/ Title Menu") {
    TitleDisplayModesDemo(mode: .inline, titleMenu: true)
}

#Preview("Automatic") {
    TitleDisplayModesDemo(mode: .automatic)
}

#Preview("Leading + Trailing") {
    TitleDisplayModesDemo(mode: .inline, toolbarItems: .leadingAndTrailing)
}

#Preview("Item Group") {
    TitleDisplayModesDemo(mode: .inline, toolbarItems: .itemGroup)
}

#Preview("Five Items") {
    TitleDisplayModesDemo(mode: .inline, toolbarItems: .fiveItems)
}

#Preview("Custom Title") {
    TitleDisplayModesDemo(mode: .large, toolbarItems: .customTitle)
}

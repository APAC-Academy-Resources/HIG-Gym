import SwiftUI

struct ToolbarItemsDemoView: View {
    // MARK: - Variant
    enum Variant {
        case singleItemTopTrailing
        case singleItemPrincipal
        case principalTrailingItems
        case undoRedoPlusPrimary
        case dualClusters
        case overflow
        case singleItemBottom
        case customBottom
        case customTop
        case mixed
    }
    
    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Toolbar item placement",
        description: "The top toolbar has 3 main 'slots' leading, trailing, and principal. While the bottom one is just a single large 'slot'.",
        systemImage: "wrench.and.screwdriver.fill"
    )

    // MARK: - Properties & Methods
    @State private var selected = 1
    @State private var isOn = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            content
        }
    }

    // MARK: - View Components
    private var base: some View {
        DemoScrollView(count: 20)
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle("Toolbar Items")
            .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
            .safeAreaBar(edge: .bottom) {
                infoCard
                    .padding(.horizontal)
            }
    }

    private var content: some View {
        switch variant {
        case .singleItemTopTrailing: AnyView(base.toolbar { singleItemTopTrailing })
        case .singleItemPrincipal: AnyView(base.toolbar { singleItemPrincipal })
        case .principalTrailingItems: AnyView(base.toolbar { principalTrailingItems })
        case .undoRedoPlusPrimary: AnyView(base.toolbar { DemoSimpleTopToolbar() })
        case .dualClusters: AnyView(base.toolbar { dualClusters })
        case .overflow: AnyView(base.toolbar { overflow })
        case .singleItemBottom: AnyView(base.toolbar { singleItemBottom })
        case .customBottom: AnyView(base.toolbar { customBottom })
        case .customTop: AnyView(base.toolbar { customTop })
        case .mixed: AnyView(base.toolbar { mixed })
        }
    }
    
    private func profileImageButton(size: CGFloat = 32) -> some View {
        Button { } label: {
            Image("g")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(.circle)
        }
        .accessibilityLabel("Profile")
    }
    
    @ToolbarContentBuilder
    private var singleItemTopTrailing: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Filter", systemImage: "line.3.horizontal.decrease") { }
        }
    }

    @ToolbarContentBuilder
    private var singleItemPrincipal: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            profileImageButton(size: 48)
        }
    }

    @ToolbarContentBuilder
    private var principalTrailingItems: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            profileImageButton()
        }
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button("Bookmark", systemImage: "bookmark") { }
            Button("Favourite", systemImage: "star") { }
            Button("Tag", systemImage: "tag") { }
            Button("Edit", systemImage: "square.and.pencil") { }
        }
    }

    @ToolbarContentBuilder
    private var dualClusters: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            EditButton()
        }
        ToolbarItemGroup(placement: .topBarLeading) {
            Button("Shareplay", systemImage: "shareplay") { }
            Button("Airplay", systemImage: "airplay.audio") { }
        }
    }

    @ToolbarContentBuilder
    private var overflow: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            Button("Search", systemImage: "magnifyingglass") { }
            Button("Share", systemImage: "square.and.arrow.up") { }
        }
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button("Bookmark", systemImage: "bookmark") { }
            Button("Favourite", systemImage: "star") { }
            Button("Tag", systemImage: "tag") { }
            Button("Edit", systemImage: "square.and.pencil") { }
            Button("Person", systemImage: "person") { }
            Button("Scribble", systemImage: "scribble") { }
        }
    }

    @ToolbarContentBuilder
    private var singleItemBottom: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            profileImageButton(size: 30)
        }
        ToolbarSpacer(placement: .bottomBar)
    }

    @ToolbarContentBuilder
    private var customBottom: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            profileImageButton(size: 30)
        }
        ToolbarSpacer(placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "location.fill")
                        .font(.caption)
                        .foregroundStyle(.blue)
                    Text("Surabaya, ID")
                }
                Text("GMT+7")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
        }
        ToolbarSpacer(placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
            Button(role: .confirm) { }
        }
    }
    
    @ToolbarContentBuilder
    private var customTop: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            profileImageButton(size: 30)
        }
        ToolbarItem(placement: .principal) {
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "location.fill")
                        .font(.caption)
                        .foregroundStyle(.blue)
                    Text("Surabaya, ID")
                }
                Text("GMT+7")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Bookmark", systemImage:  "bookmark") { }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button(role: .confirm) { }
        }
    }

    @ToolbarContentBuilder
    private var mixed: some ToolbarContent {
        DemoMixedTopToolbar()
        ToolbarItemGroup(placement: .bottomBar) {
            Button("Back", systemImage: "chevron.backward") { }
            Button("Forward", systemImage: "chevron.forward") { }
        }
        ToolbarSpacer(placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
            DemoMenuView()
        }
        ToolbarSpacer(placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
            Toggle(isOn: $isOn) {
                Label("Bulb", systemImage: isOn ? "lightbulb.min" : "lightbulb")
            }
        }
    }
}

#Preview("Single Item Top Trailing") {
    ToolbarItemsDemoView(variant: .singleItemTopTrailing)
        .tint(.blue)
}

#Preview("Single Item Principal") {
    ToolbarItemsDemoView(variant: .singleItemPrincipal)
        .tint(.blue)
}

#Preview("Undo/Redo + Primary") {
    ToolbarItemsDemoView(variant: .undoRedoPlusPrimary)
        .tint(.blue)
}

#Preview("Dual Clusters") {
    ToolbarItemsDemoView(variant: .dualClusters)
        .tint(.blue)
}

#Preview("Overflow") {
    ToolbarItemsDemoView(variant: .overflow)
        .tint(.blue)
}

#Preview("Single Item Bottom") {
    ToolbarItemsDemoView(variant: .singleItemBottom)
        .tint(.blue)
}

#Preview("Custom View Bottom") {
    ToolbarItemsDemoView(variant: .customBottom)
        .tint(.blue)
}

#Preview("Custom View Top") {
    ToolbarItemsDemoView(variant: .customTop)
        .tint(.blue)
}

#Preview("Mixed") {
    ToolbarItemsDemoView(variant: .mixed)
        .tint(.blue)
}

#Preview("Principal w/ Trailing Items") {
    ToolbarItemsDemoView(variant: .principalTrailingItems)
        .tint(.blue)
}

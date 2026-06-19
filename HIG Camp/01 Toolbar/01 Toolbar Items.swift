import SwiftUI

enum ToolbarItemsVariant {
    case singleItemTopTrailing
    case singleItemPrincipal
    case principalTrailingItems
    case undoRedoPlusPrimary
    case dualClusters
    case overflow
    case singleItemBottom
    case customBottom
    case mixed
}

struct ToolbarItemsDemoView: View {
    let variant: ToolbarItemsVariant
    @State private var selected = 1
    @State private var isOn = false
    
    var body: some View {
        NavigationStack {
            scrollView
                .toolbarTitleDisplayMode(.inline)
                .navigationTitle("Toolbar Items")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
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

    @ViewBuilder
    private var scrollView: some View {
        let base = DemoScrollView(count: 20)
        switch variant {
        case .singleItemTopTrailing: base.toolbar { singleItemTopTrailing }
        case .singleItemPrincipal: base.toolbar { singleItemPrincipal }
        case .principalTrailingItems: base.toolbar { principalTrailingItems }
        case .undoRedoPlusPrimary: base.toolbar { undoRedoPlusPrimary }
        case .dualClusters: base.toolbar { dualClusters }
        case .overflow: base.toolbar { overflow }
        case .singleItemBottom: base.toolbar { singleItemBottom }
        case .customBottom: base.toolbar { customBottom }
        case .mixed: base.toolbar { mixed }
        }
    }

    @ToolbarContentBuilder
    private var singleItemTopTrailing: some ToolbarContent {
        // Single item gets its own isolated floating pill
        ToolbarItem(placement: .topBarTrailing) {
            Button("Filter", systemImage: "line.3.horizontal.decrease") { }
        }
    }

    @ToolbarContentBuilder
    private var singleItemPrincipal: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            profileImageButton()
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
            Button(
                "Edit",
                systemImage: "square.and.pencil"
            ) { }
        }
    }

    @ToolbarContentBuilder
    private var undoRedoPlusPrimary: some ToolbarContent {
        // Items sharing a placement cluster; different placements stay separate
        ToolbarItemGroup(placement: .topBarLeading) {
            Button("Undo", systemImage: "arrow.uturn.backward") { }
            Button("Redo", systemImage: "arrow.uturn.forward") { }
        }
        ToolbarItem(placement: .primaryAction) {
            Button("Add", systemImage: "plus") { }
                .buttonStyle(.borderedProminent)
        }
    }

    @ToolbarContentBuilder
    private var dualClusters: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            Button("Menu", systemImage: "line.3.horizontal") { }
            Button("Back", systemImage: "chevron.left") { }
        }
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button("Search", systemImage: "magnifyingglass") { }
            Button("More", systemImage: "ellipsis.circle") { }
        }
    }

    @ToolbarContentBuilder
    private var overflow: some ToolbarContent {
        // Overflow into … is automatic — the system decides the threshold
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
            Button("OK", systemImage: "checkmark", role: .confirm) { }
        }
    }

    @ToolbarContentBuilder
    private var mixed: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            profileImageButton()
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Search", systemImage: "sparkle.magnifyingglass") { }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Pen", systemImage: "scribble") { }
        }
        ToolbarSpacer(placement: .topBarTrailing)
        ToolbarItem(placement: .topBarTrailing) {
            Button("Files", systemImage: "folder") { }
        }
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
}

#Preview("Single Item Principal") {
    ToolbarItemsDemoView(variant: .singleItemPrincipal)
}

#Preview("Undo/Redo + Primary") {
    ToolbarItemsDemoView(variant: .undoRedoPlusPrimary)
}

#Preview("Dual Clusters") {
    ToolbarItemsDemoView(variant: .dualClusters)
}

#Preview("Overflow") {
    ToolbarItemsDemoView(variant: .overflow)
}

#Preview("Single Item Bottom") {
    ToolbarItemsDemoView(variant: .singleItemBottom)
}

#Preview("Custom View Bottom") {
    ToolbarItemsDemoView(variant: .customBottom)
}

#Preview("Mixed") {
    ToolbarItemsDemoView(variant: .mixed)
}

#Preview("Principal w/ Trailing Items") {
    ToolbarItemsDemoView(variant: .principalTrailingItems)
}

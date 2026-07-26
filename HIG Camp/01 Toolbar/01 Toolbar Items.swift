//
//  01 Toolbar Items.swift
//  HIG Camp
//

import SwiftUI

struct ToolbarItemsDemo: View {
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
        description: "The top toolbar has 3 main slots: leading, trailing, and principal. While the bottom one is just a single large slot.",
        systemImage: "wrench.and.screwdriver.fill"
    )

    // MARK: - State
    @State private var isOn = false

    private let tint: Color = .blue

    // MARK: - Body
    var body: some View {
        NavigationStack {
            content
        }
        .tint(tint)
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

    @ViewBuilder
    private var content: some View {
        switch variant {
        case .singleItemTopTrailing: base.toolbar { singleItemTopTrailing }
        case .singleItemPrincipal: base.toolbar { singleItemPrincipal }
        case .principalTrailingItems: base.toolbar { principalTrailingItems }
        case .undoRedoPlusPrimary: base.toolbar { DemoSimpleTopToolbar() }
        case .dualClusters: base.toolbar { dualClusters }
        case .overflow: base.toolbar { overflow }
        case .singleItemBottom: base.toolbar { singleItemBottom }
        case .customBottom: base.toolbar { customBottom }
        case .customTop: base.toolbar { customTop }
        case .mixed: base.toolbar { mixed }
        }
    }

    private func profileImage(size: CGFloat = 32) -> some View {
        Image("g")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(.circle)
    }

    private var profileLockup: some View {
        Button {
        } label: {
            HStack {
                profileImage(size: 32)
                VStack(alignment: .leading) {
                    Text("George Ananda")
                    Text("HIG Snob")
                        .font(.caption)
                        .textCase(.uppercase)
                        .opacity(0.6)
                        .bold()
                }
            }
        }
        .buttonStyle(.plain)
    }

    /// The same lockup reads well in a bottom bar slot and in the principal slot.
    private var locationLockup: some View {
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

    @ToolbarContentBuilder
    private var singleItemTopTrailing: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Filter", systemImage: "line.3.horizontal.decrease") { }
        }
    }

    @ToolbarContentBuilder
    private var singleItemPrincipal: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            profileLockup
        }
    }

    @ToolbarContentBuilder
    private var principalTrailingItems: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            profileLockup
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
            profileImage(size: 32)
        }
        ToolbarSpacer(placement: .bottomBar)
    }

    @ToolbarContentBuilder
    private var customBottom: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            profileImage(size: 30)
        }
        ToolbarSpacer(placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
            locationLockup
        }
        ToolbarSpacer(placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
            Button(role: .confirm) { }
        }
    }

    @ToolbarContentBuilder
    private var customTop: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            profileImage(size: 30)
        }
        ToolbarItem(placement: .principal) {
            locationLockup
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button("Bookmark", systemImage: "bookmark") { }
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
    ToolbarItemsDemo(variant: .singleItemTopTrailing)
}

#Preview("Single Item Principal") {
    ToolbarItemsDemo(variant: .singleItemPrincipal)
}

#Preview("Undo/Redo + Primary") {
    ToolbarItemsDemo(variant: .undoRedoPlusPrimary)
}

#Preview("Dual Clusters") {
    ToolbarItemsDemo(variant: .dualClusters)
}

#Preview("Overflow") {
    ToolbarItemsDemo(variant: .overflow)
}

#Preview("Single Item Bottom") {
    ToolbarItemsDemo(variant: .singleItemBottom)
}

#Preview("Custom View Bottom") {
    ToolbarItemsDemo(variant: .customBottom)
}

#Preview("Custom View Top") {
    ToolbarItemsDemo(variant: .customTop)
}

#Preview("Mixed") {
    ToolbarItemsDemo(variant: .mixed)
}

#Preview("Principal w/ Trailing Items") {
    ToolbarItemsDemo(variant: .principalTrailingItems)
}

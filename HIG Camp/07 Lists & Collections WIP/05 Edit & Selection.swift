//
//  05 Edit & Selection.swift
//  HIG Camp
//

import SwiftUI

struct EditAndSelectionDemo: View {
    // MARK: - Variant
    enum Variant {
        case reordering
        case deleting
        case selecting
    }

    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Edit & selection",
        description: "An EditButton flips the environment's edit mode. In edit mode a List with a selection binding allows multi-select, while onMove and onDelete enable reordering and removal.",
        systemImage: "checklist"
    )

    // MARK: - State
    @State private var items: [String] = (1...8).map { "Item \($0)" }
    @State private var selection = Set<String>()
    @State private var tint: Color = .demoRandom
    @State private var isDarkMode = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            List(selection: variant == .selecting ? $selection : nil) {
                Section {
                    switch variant {
                    case .reordering:
                        ForEach(items, id: \.self) { item in
                            Text(item)
                        }
                        .onMove { items.move(fromOffsets: $0, toOffset: $1) }
                    case .deleting:
                        ForEach(items, id: \.self) { item in
                            Text(item)
                        }
                        .onDelete { items.remove(atOffsets: $0) }
                    case .selecting:
                        ForEach(items, id: \.self) { item in
                            Text(item)
                        }
                    }
                } header: {
                    Text("Items")
                } footer: {
                    switch variant {
                    case .reordering:
                        caption("`.onMove(perform:)` on a `ForEach` shows drag handles in edit mode.")
                    case .deleting:
                        caption("`.onDelete(perform:)` adds the red minus badge and the swipe-to-delete gesture.")
                    case .selecting:
                        caption("`List(selection:)` bound to a `Set` allows multi-select once `EditButton` turns edit mode on. \(selection.count) selected.")
                    }
                }
            }
            .navigationTitle("Edit & Selection")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                toolbar
            }
            .safeAreaBar(edge: .top) {
                infoCard
                    .padding()
            }
            .animation(.easeInOut, value: tint)
        }
        .tint(tint)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            EditButton()
        }
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Tint", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = .demoRandom
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $isDarkMode)
        }
    }
}

#Preview("Reordering") {
    EditAndSelectionDemo(variant: .reordering)
}

#Preview("Deleting") {
    EditAndSelectionDemo(variant: .deleting)
}

#Preview("Selecting") {
    EditAndSelectionDemo(variant: .selecting)
}

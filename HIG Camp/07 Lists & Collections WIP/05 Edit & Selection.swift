//
//  05 Edit & Selection.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct EditAndSelection: View {
    // MARK: - Variants
    enum Variant {
        case reordering
        case deleting
        case selecting
        case all
    }
    
    let variant: Variant
    
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Edit & selection",
        description: "An EditButton flips the environment's edit mode. In edit mode a List with a selection binding allows multi-select, while onMove and onDelete enable reordering and removal.",
        systemImage: "checklist"
    )

    // MARK: - Properties & Methods
    @State private var items: [String] = (1...8).map { "Item \($0)" }
    @State private var selection = Set<String>()
    @State private var tint: Color = EditAndSelection.getRandomColor()

    static func getRandomColor() -> Color {
        Color(
            hue: .random(in: 0...1),
            saturation: .random(in: 0.4...0.8),
            brightness: .random(in: 0.6...0.8)
        )
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
//                Section {
//                    Text("\(selection.count) selected")
//                        .foregroundStyle(.tint)
//                }

                Section("Items") {
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
                    default:
                        ForEach(items, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
            }
            .navigationTitle("Edit & Selection")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                toolbar
            }
            .safeAreaBar(edge: .top, content: {
                infoCard
                    .padding()
            })
            .animation(.easeInOut, value: tint)
        }
        .tint(tint)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            EditButton()
        }
    }
}

#Preview("Reordering") {
    EditAndSelection(variant: .reordering)
}

#Preview("Deleting") {
    EditAndSelection(variant: .deleting)
}

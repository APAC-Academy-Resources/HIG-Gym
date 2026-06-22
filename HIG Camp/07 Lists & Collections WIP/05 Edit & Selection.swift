//
//  05 Edit & Selection.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct EditAndSelection: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Edit & selection",
        description: "An EditButton flips the environment's edit mode. In edit mode a List with a selection binding allows multi-select, while onMove and onDelete enable reordering and removal.",
        systemImage: "checklist"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var items: [String] = (1...8).map { "Task \($0)" }
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
            List(selection: $selection) {
                Section {
                    infoCard
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                Section {
                    Text("\(selection.count) selected")
                        .foregroundStyle(.tint)
                }

                Section("Tasks") {
                    ForEach(items, id: \.self) { item in
                        Label(item, systemImage: "circle")
                    }
                    .onMove { items.move(fromOffsets: $0, toOffset: $1) }
                    .onDelete { items.remove(atOffsets: $0) }
                }
            }
            .navigationTitle("Edit & Selection")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                toolbar
            }
            .animation(.easeInOut, value: tint)
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            EditButton()
        }
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = EditAndSelection.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
        }
    }
}

#Preview {
    EditAndSelection()
}

import SwiftUI

enum LiquidGlassVariant {
    case singleItem           // lone item → isolated glass pill
    case undoRedoPlusPrimary  // grouped undo/redo + separate prominent primary
    case dualClusters         // leading items + trailing items → two separate clusters
    case overflow             // 6 trailing items → system collapses to … pill
    case mixed                // non button items
}

struct ToolbarItemsDemoView: View {
    let variant: LiquidGlassVariant
    @State var selected: Int = 1
    @State var isOn: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(0..<20) { index in
                        DemoRow(label: "Item \(index + 1)")
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Liquid Glass Toolbar")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                switch variant {
                case .singleItem:
                    // Single item gets its own isolated floating pill
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Filter", systemImage: "line.3.horizontal.decrease") { }
                    }

                case .undoRedoPlusPrimary:
                    // Items sharing a placement cluster; different placements stay separate
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Undo", systemImage: "arrow.uturn.backward") { }
                        Button("Redo", systemImage: "arrow.uturn.forward") { }
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button("Add", systemImage: "plus") { }
                            .buttonStyle(.borderedProminent)
                    }

                case .dualClusters:
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Menu", systemImage: "line.3.horizontal") { }
                        Button("Back", systemImage: "chevron.left") { }
                    }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Search", systemImage: "magnifyingglass") { }
                        Button("More", systemImage: "ellipsis.circle") { }
                    }

                case .overflow:
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
                    
                case .mixed:
                    ToolbarItem(placement: .topBarTrailing) {
                        Picker(selection: $selected) {
                            Text("First").tag(1)
                            Text("Second").tag(2)
                        } label: {
                            Text("Picker")
                        }
                        .pickerStyle(.segmented)
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button("back", systemImage: "chevron.backward") { }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button("forward", systemImage: "chevron.forward") { }
                    }
                    
                    ToolbarSpacer(placement: .bottomBar)
                    
                    ToolbarItem(placement: .bottomBar) {
                        Menu {
                            Label("Third", systemImage: "3.circle.fill")
                            Label("Second", systemImage: "2.circle.fill")
                            Label("First", systemImage: "1.circle.fill")
                        } label: {
                            Text("Menu")
                        }

                    }
                    
                    ToolbarSpacer(placement: .bottomBar)
                    
                    ToolbarItem(placement: .bottomBar) {
                        Toggle(isOn: $isOn) {
                            Label("Bulb", systemImage: "lightbulb")
                        }
                        .toggleStyle(.button)
                    }
                }
            }
        }
    }
}

#Preview("Single Item") {
    ToolbarItemsDemoView(variant: .singleItem)
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

#Preview("Mixed") {
    ToolbarItemsDemoView(variant: .mixed)
}

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
            DemoScrollView(count: 20)
            .background(.blue.gradient.opacity(0.7))
            .tint(.blue)
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle("Toolbar Items")
            .navigationDestination(for: String.self) { item in
                DemoDetailView(item: item)
            }
            .safeAreaBar(edge: .bottom, content: {
                HStack {
                    Spacer()
                    Button("Add", systemImage: "plus") {}
                        .buttonStyle(.glassProminent)
                        .controlSize(.large)
                        .labelStyle(.iconOnly)
                        .buttonBorderShape(.circle)
                }
                .padding(.horizontal, 24)
                .padding(.bottom)
            })
            .toolbar { toolbarContent }
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
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
                    ToolbarItem(placement: .topBarLeading) {
                        Button { } label: {
                            Image("g")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                                .clipShape(.circle)
                        }
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
                    Button("back", systemImage: "chevron.backward") { }
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
                                Label("Bulb", systemImage: isOn ? "lightbulb.min" : "lightbulb")
                            }
                            .toggleStyle(.button)
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

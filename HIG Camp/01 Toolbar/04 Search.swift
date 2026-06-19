import SwiftUI

struct ToolbarSearchDemoView: View {
    let placement: SearchFieldPlacement
    var bottomItems: Bool = false

    var body: some View {
        NavigationStack {
            DemoSearchView(placement: placement, prompt: "Search items")
                .background(Color(.tintColor).opacity(0.8).gradient)
                .toolbarTitleDisplayMode(.inline)
                .navigationTitle("Search")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Add", systemImage: "plus") { }
                            .buttonStyle(.borderedProminent)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Sort", systemImage: "arrow.up.arrow.down") { }
                    }
                    if bottomItems {
                        ToolbarSpacer(placement: .bottomBar)
                        ToolbarItem(placement: .bottomBar) {
                            Button("Map", systemImage: "Map") { }
                        }
                    }
                }
        }
    }
}

#Preview("Toolbar") {
    ToolbarSearchDemoView(placement: .toolbar)
        .tint(.green)
}

#Preview("Toolbar + bottom items") {
    ToolbarSearchDemoView(placement: .toolbar, bottomItems: true)
        .tint(.green)
}

#Preview("Drawer") {
    ToolbarSearchDemoView(placement: .navigationBarDrawer)
        .tint(.green)
}

#Preview("Drawer Always") {
    ToolbarSearchDemoView(placement: .navigationBarDrawer(displayMode: .always))
        .tint(.green)
}

#Preview("Toolbar Principal") {
    ToolbarSearchDemoView(placement: .toolbarPrincipal)
        .tint(.green)
}

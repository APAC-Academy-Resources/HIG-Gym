import SwiftUI

struct DemoDetailView: View {
    let item: String
    var tabBarHiddenOnDetail: Bool = true

    var body: some View {
        ScrollView {
            Text("Detail content for \(item)")
                .padding()
        }
        .toolbarTitleDisplayMode(.inline)
        .navigationTitle(item)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Share", systemImage: "square.and.arrow.up") { }
                Button("Bookmark", systemImage: "bookmark") { }
                Button("More", systemImage: "ellipsis.circle") { }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Previous", systemImage: "chevron.left") { }
                Spacer()
                Button("Next", systemImage: "chevron.right") { }
            }
        }
        .toolbar(tabBarHiddenOnDetail ? .hidden : .visible, for: .tabBar)
    }
}

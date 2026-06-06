import SwiftUI

struct TopSafeAreaBarDemoView: View {
    let showMaterial: Bool

    @State private var selectedSegment = 0

    var body: some View {
        NavigationStack {
            DemoScrollView(count: 35)
            .background(.orange.gradient.opacity(0.7))
            .tint(.orange)
            .safeAreaBar(edge: .top) {
                Picker("View", selection: $selectedSegment) {
                    Text("All").tag(0)
                    Text("Unread").tag(1)
                    Text("Flagged").tag(2)
                }
                .controlSize(.large)
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(
                    showMaterial ? AnyShapeStyle(.ultraThinMaterial) : AnyShapeStyle(.clear)
                )
            }
            .navigationTitle("Safe Area Bar")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") { }
                }
            }
        }
    }
}

#Preview("With Background") {
    TopSafeAreaBarDemoView(showMaterial: true)
}

#Preview("Without Background") {
    TopSafeAreaBarDemoView(showMaterial: false)
}

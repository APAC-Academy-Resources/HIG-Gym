import SwiftUI

struct TopSafeAreaBarDemoView: View {
    let showMaterial: Bool

    @State private var selectedSegment = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(0..<35) { index in
                        DemoRow(label: "Item \(index + 1)")
                    }
                }
                .padding(.vertical)
            }
            .safeAreaBar(edge: .top) {
                Picker("View", selection: $selectedSegment) {
                    Text("All").tag(0)
                    Text("Unread").tag(1)
                    Text("Flagged").tag(2)
                }
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

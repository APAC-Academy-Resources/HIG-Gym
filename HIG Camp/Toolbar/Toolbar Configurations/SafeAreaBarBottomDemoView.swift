import SwiftUI

struct BottomSafeAreaBarDemoView: View {
    let showMaterial: Bool

    @State private var selectedSegment = 0
    @State private var isOn = false

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
            // Place .safeAreaBar on ScrollView, not NavigationStack
            .safeAreaBar(edge: .bottom) {
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
                ToolbarItem(placement: .bottomBar) {
                    Toggle(isOn: $isOn) {
                        Label("Filter", systemImage: "line.3.horizontal.decrease")
                    }
                    .toggleStyle(.button)
                }
                ToolbarSpacer(placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) {
                    Button("Erase", systemImage: "square.and.arrow.up") { }
                }

                ToolbarItem(placement: .bottomBar) {
                    Button("Write", systemImage: "pencil.and.scribble") { }
                }
            }
        }
    }
}

#Preview("With Background") {
    BottomSafeAreaBarDemoView(showMaterial: true)
}

#Preview("Without Background") {
    BottomSafeAreaBarDemoView(showMaterial: false)
}

import SwiftUI

struct FullScreenCoverDemoView: View {
    @State private var isOpen = false

    var body: some View {
        NavigationStack {
            DemoScrollView(count: 20)
                .toolbarTitleDisplayMode(.inlineLarge)
                .navigationTitle("List")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                .toolbar {
                    ToolbarSpacer(placement: .bottomBar)
                    ToolbarItem(placement: .bottomBar) {
                        Button("Check", systemImage: "checklist") {
                            isOpen.toggle()
                        }
                    }
                }
                .fullScreenCover(isPresented: $isOpen) {
                    DemoModalView(isOpen: $isOpen, title: "Fullscreen Cover")
                }
        }
    }
}

#Preview {
    FullScreenCoverDemoView()
        .tint(.brown)
}

import SwiftUI

struct FullScreenCoverDemoView: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Full Screen Cover",
        description: "Unlike a sheet, a cover takes the whole screen and has no drag-to-dismiss — you dismiss it explicitly. Tap \"Check\" to present.",
        systemImage: "rectangle.inset.filled"
    )

    // MARK: - Properties & Methods
    @State private var isOpen = false

    // MARK: - Body
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
                .safeAreaBar(edge: .top) {
                    infoCard
                        .padding(.horizontal)
                }
        }
    }
}

#Preview {
    FullScreenCoverDemoView()
        .tint(.brown)
}

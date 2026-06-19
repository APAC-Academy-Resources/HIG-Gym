import SwiftUI

struct PresentationDetentsDemoView: View {
    var detents: Set<PresentationDetent> = [.large]
    var interactable: Bool = false
    @State private var isOpen = false
    @State private var selectedDetent: PresentationDetent = .large

    var body: some View {
        NavigationStack {
            DemoScrollView(count: 20)
                .toolbarTitleDisplayMode(.inlineLarge)
                .navigationTitle("List")
                .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
                .toolbar {
                    ToolbarSpacer(placement: .bottomBar)
                    ToolbarItem(placement: .bottomBar) {
                        Button("Open", systemImage: "folder") {
                            isOpen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $isOpen) {
                    DemoModalView(isOpen: $isOpen)
                        .presentationDetents(detents, selection: $selectedDetent)
                        .presentationDragIndicator(.visible)
                        .presentationBackgroundInteraction(interactable ? .enabled : .disabled)
                }
        }
    }
}

#Preview("Large") {
    PresentationDetentsDemoView(detents: [.large])
        .tint(.purple)
}

#Preview("Medium") {
    PresentationDetentsDemoView(detents: [.medium])
        .tint(.indigo)
}

#Preview("Custom Short") {
    PresentationDetentsDemoView(detents: [.height(200)])
        .tint(.blue)
}

#Preview("Combo") {
    PresentationDetentsDemoView(detents: [.large, .medium, .height(200)])
        .tint(.cyan)
}

#Preview("Nonmodal Sheet") {
    PresentationDetentsDemoView(detents: [.height(200)], interactable: true)
        .tint(.cyan)
}

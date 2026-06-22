import SwiftUI

struct TransitionsDemoView: View {
    // MARK: - Variant
    enum Variant {
        case standard
        case zoomSheet
        case zoomCover
    }

    let style: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Presentation Transitions",
        description: "The zoom transition morphs the tapped control into the presented view (matchedTransitionSource + .zoom). Compare with the standard slide-up.",
        systemImage: "arrow.up.left.and.arrow.down.right"
    )

    // MARK: - Properties & Methods
    @State private var isOpen = false
    @Namespace private var namespace

    private let zoomID = "zoom"

    // MARK: - Body
    var body: some View {
        NavigationStack {
            switch style {
            case .standard:
                baseList
                    .toolbar {
                        ToolbarSpacer(placement: .bottomBar)
                        ToolbarItem(placement: .bottomBar) {
                            Button("List", systemImage: "checklist") {
                                isOpen = true
                            }
                        }
                    }
                    .sheet(isPresented: $isOpen) {
                        DemoModalView(isOpen: $isOpen)
                    }

            case .zoomSheet:
                baseList
                    .toolbar {
                        ToolbarSpacer(placement: .bottomBar)
                        ToolbarItem(placement: .bottomBar) {
                            Button("Zoom", systemImage: "arrow.up.left.and.arrow.down.right") {
                                isOpen = true
                            }
                        }
                        .matchedTransitionSource(id: zoomID, in: namespace)
                    }
                    .sheet(isPresented: $isOpen) {
                        DemoModalView(isOpen: $isOpen)
                            .navigationTransition(.zoom(sourceID: zoomID, in: namespace))
                    }

            case .zoomCover:
                baseList
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Zoom", systemImage: "arrow.up.left.and.arrow.down.right") {
                                isOpen = true
                            }
                        }
                        .matchedTransitionSource(id: zoomID, in: namespace)
                    }
                    .fullScreenCover(isPresented: $isOpen) {
                        DemoModalView(isOpen: $isOpen, title: "Fullscreen Cover")
                            .navigationTransition(.zoom(sourceID: zoomID, in: namespace))
                    }
            }
        }
    }

    // MARK: - View Components
    private var baseList: some View {
        DemoScrollView(count: 20)
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationTitle("List")
            .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
            .safeAreaBar(edge: .bottom) {
                infoCard
                    .padding(.horizontal)
            }
    }
}

#Preview("Default") {
    TransitionsDemoView(style: .standard)
        .tint(.mint)
}

#Preview("Zoom (Sheet)") {
    TransitionsDemoView(style: .zoomSheet)
        .tint(.orange)
}

#Preview("Zoom (Full Screen Cover)") {
    TransitionsDemoView(style: .zoomCover)
        .tint(.green)
}

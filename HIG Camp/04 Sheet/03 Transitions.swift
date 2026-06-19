import SwiftUI

enum TransitionsVariant {
    case standard
    case zoomSheet
    case zoomCover
}

struct TransitionsDemoView: View {
    let style: TransitionsVariant
    @State private var isOpen = false
    @Namespace private var namespace

    private let zoomID = "zoom"

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

    private var baseList: some View {
        DemoScrollView(count: 20)
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationTitle("List")
            .navigationDestination(for: String.self) { DemoDetailView(item: $0) }
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

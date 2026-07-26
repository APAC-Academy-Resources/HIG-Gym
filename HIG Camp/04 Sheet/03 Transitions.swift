//
//  03 Transitions.swift
//  HIG Camp
//

import SwiftUI

struct TransitionsDemo: View {
    // MARK: - Variant
    enum Variant {
        case standard
        case zoomSheet
        case zoomCover
    }

    let variant: Variant

    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Presentation Transitions",
        description: "The zoom transition morphs the tapped control into the presented view (matchedTransitionSource + .zoom). Compare with the standard slide-up.",
        systemImage: "arrow.up.left.and.arrow.down.right"
    )

    // MARK: - State
    @State private var isOpen = false
    @Namespace private var namespace

    private let zoomID = "zoom"
    private let tint: Color = .mint

    // MARK: - Body
    var body: some View {
        NavigationStack {
            switch variant {
            case .standard:
                baseList
                    .toolbar { toolbar }
                    .sheet(isPresented: $isOpen) {
                        DemoModalView(isOpen: $isOpen)
                    }

            case .zoomSheet:
                baseList
                    .toolbar { toolbar }
                    .sheet(isPresented: $isOpen) {
                        DemoModalView(isOpen: $isOpen)
                            .navigationTransition(.zoom(sourceID: zoomID, in: namespace))
                    }

            case .zoomCover:
                baseList
                    .toolbar { toolbar }
                    .fullScreenCover(isPresented: $isOpen) {
                        DemoModalView(isOpen: $isOpen, title: "Fullscreen Cover")
                            .navigationTransition(.zoom(sourceID: zoomID, in: namespace))
                    }
            }
        }
        .tint(tint)
    }

    // MARK: - View Components
    /// The control that presents. `.matchedTransitionSource` marks it as the
    /// shape the zoom transition grows out of, so it has to sit on the button —
    /// only the placement and label differ per variant.
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        switch variant {
        case .standard:
            ToolbarSpacer(placement: .bottomBar)
            ToolbarItem(placement: .bottomBar) {
                Button("List", systemImage: "checklist") {
                    isOpen = true
                }
            }

        case .zoomSheet:
            ToolbarSpacer(placement: .bottomBar)
            ToolbarItem(placement: .bottomBar) {
                Button("Zoom", systemImage: "arrow.up.left.and.arrow.down.right") {
                    isOpen = true
                }
            }
            .matchedTransitionSource(id: zoomID, in: namespace)

        case .zoomCover:
            ToolbarItem(placement: .topBarTrailing) {
                Button("Zoom", systemImage: "arrow.up.left.and.arrow.down.right") {
                    isOpen = true
                }
            }
            .matchedTransitionSource(id: zoomID, in: namespace)
        }
    }

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
    TransitionsDemo(variant: .standard)
}

#Preview("Zoom (Sheet)") {
    TransitionsDemo(variant: .zoomSheet)
}

#Preview("Zoom (Full Screen Cover)") {
    TransitionsDemo(variant: .zoomCover)
}

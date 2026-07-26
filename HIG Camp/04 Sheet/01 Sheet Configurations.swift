//
//  01 Sheet Configurations.swift
//  HIG Camp
//

import SwiftUI

struct SheetConfigurationsDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Presentation Detents",
        description: "Detents set the heights a sheet can rest at (medium, large, custom). Drag the sheet between them. \"Nonmodal\" lets you interact with the list behind it.",
        systemImage: "rectangle.portrait.bottomhalf.filled"
    )

    // MARK: - State
    /// Orthogonal switches rather than one `Variant` enum — a preview mixes and
    /// matches them freely (custom height *and* nonmodal, for instance).
    var detents: Set<PresentationDetent> = [.large]
    var interactable: Bool = false
    var useMiniToolbar: Bool = false

    @State private var isOpen = false
    @State private var selectedDetent: PresentationDetent = .large

    private let tint: Color = .purple

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
                        Button("Open", systemImage: "folder") {
                            isOpen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $isOpen) {
                    DemoModalView(isOpen: $isOpen, useMiniToolbar: useMiniToolbar)
                        .presentationDetents(detents, selection: $selectedDetent)
                        .presentationDragIndicator(.visible)
                        .presentationBackgroundInteraction(interactable ? .enabled : .disabled)
                }
                .safeAreaBar(edge: .top) {
                    infoCard
                        .padding(.horizontal)
                }
        }
        .tint(tint)
    }
}

#Preview("Large") {
    SheetConfigurationsDemo(detents: [.large])
}

#Preview("Medium") {
    SheetConfigurationsDemo(detents: [.medium])
}

#Preview("Medium with 34pt close") {
    SheetConfigurationsDemo(detents: [.medium], useMiniToolbar: true)
}

#Preview("Custom Short") {
    SheetConfigurationsDemo(detents: [.height(200)])
}

#Preview("Combo") {
    SheetConfigurationsDemo(detents: [.large, .medium, .height(200)])
}

#Preview("Nonmodal Sheet") {
    SheetConfigurationsDemo(detents: [.height(200)], interactable: true)
}

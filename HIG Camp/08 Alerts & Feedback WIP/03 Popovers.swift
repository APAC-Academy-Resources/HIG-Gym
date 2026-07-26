//
//  03 Popovers.swift
//  HIG Camp
//

import SwiftUI

struct PopoversDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Popovers",
        description: "popover presents content anchored to its source. On compact iPhone widths it adapts to a sheet by default; presentationCompactAdaptation(.popover) keeps the popover look.",
        systemImage: "bubble.middle.top"
    )

    // MARK: - State
    @State private var showAdaptive: Bool = false
    @State private var showPopover: Bool = false

    // MARK: - Body
    var body: some View {
        DemoPage("Popovers", info: infoCard) { _ in
            DemoSection("Default (adapts to a sheet)") {
                Button("Show Popover") { showAdaptive = true }
                    .buttonStyle(.borderedProminent)
                    .popover(isPresented: $showAdaptive) {
                        popoverContent
                    }
                caption("`.popover(isPresented:)` falls back to a sheet at compact widths.")
            }

            DemoSection("Forced popover") {
                Button("Show Popover") { showPopover = true }
                    .buttonStyle(.borderedProminent)
                    .popover(isPresented: $showPopover) {
                        popoverContent
                            .presentationCompactAdaptation(.popover)
                    }
                caption("`.presentationCompactAdaptation(.popover)` keeps the anchored popover on iPhone.")
            }
        }
    }

    // MARK: - View Components
    private var popoverContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Profile", systemImage: "person")
            Label("Settings", systemImage: "gearshape")
            Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
        }
        .font(.title3)
        .padding(24)
    }
}

#Preview {
    PopoversDemo()
}

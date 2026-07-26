//
//  06 Disclosure Groups.swift
//  HIG Camp
//

import SwiftUI

struct DisclosureGroupsDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Disclosure groups",
        description: "A DisclosureGroup shows or hides its content behind a toggle. It can manage its own state, bind to an isExpanded value, or nest to build a hierarchy.",
        systemImage: "chevron.down.square"
    )

    // MARK: - State
    @State private var expanded: Bool = true

    // MARK: - Body
    var body: some View {
        DemoPage("Disclosure Groups", info: infoCard, toolbar: {
            ToolbarItem(placement: .primaryAction) {
                Toggle("Expand Details", systemImage: "chevron.down", isOn: $expanded)
            }
        }) { _ in
            DemoSection("Self-managed") {
                DisclosureGroup("Account") {
                    Label("Profile", systemImage: "person")
                    Label("Privacy", systemImage: "lock")
                    Label("Notifications", systemImage: "bell")
                }
                caption("A `DisclosureGroup` keeps its own open state when you don't hand it one.")
            }

            DemoSection("Bound expansion") {
                DisclosureGroup("Details", isExpanded: $expanded) {
                    Text("This group's open state is driven by a binding, so the toolbar toggle can open and close it too.")
                        .foregroundStyle(.secondary)
                }
            }

            DemoSection("Nested") {
                DisclosureGroup("Library") {
                    DisclosureGroup("Music") {
                        Label("Playlists", systemImage: "music.note.list")
                        Label("Albums", systemImage: "square.stack")
                    }
                    DisclosureGroup("Podcasts") {
                        Label("Subscribed", systemImage: "dot.radiowaves.left.and.right")
                    }
                }
                caption("Groups nest freely — each level indents its own content.")
            }
        }
    }
}

#Preview {
    DisclosureGroupsDemo()
}

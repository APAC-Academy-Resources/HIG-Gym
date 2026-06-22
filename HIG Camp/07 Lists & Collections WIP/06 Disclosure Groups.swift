//
//  06 Disclosure Groups.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct DisclosureGroups: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Disclosure groups",
        description: "A DisclosureGroup shows or hides its content behind a toggle. It can manage its own state, bind to an isExpanded value, or nest to build a hierarchy.",
        systemImage: "chevron.down.square"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var expanded: Bool = true
    @State private var tint: Color = DisclosureGroups.getRandomColor()

    static func getRandomColor() -> Color {
        Color(
            hue: .random(in: 0...1),
            saturation: .random(in: 0.4...0.8),
            brightness: .random(in: 0.6...0.8)
        )
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    infoCard

                    section("Self-managed") {
                        DisclosureGroup("Account") {
                            Label("Profile", systemImage: "person")
                            Label("Privacy", systemImage: "lock")
                            Label("Notifications", systemImage: "bell")
                        }
                    }

                    section("Bound expansion") {
                        DisclosureGroup("Details", isExpanded: $expanded) {
                            Text("This group's open state is driven by a binding, so the toolbar toggle can open and close it too.")
                                .foregroundStyle(.secondary)
                        }
                    }

                    section("Nested") {
                        DisclosureGroup("Library") {
                            DisclosureGroup("Music") {
                                Label("Playlists", systemImage: "music.note.list")
                                Label("Albums", systemImage: "square.stack")
                            }
                            DisclosureGroup("Podcasts") {
                                Label("Subscribed", systemImage: "dot.radiowaves.left.and.right")
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Disclosure Groups")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                toolbar
            }
            .animation(.easeInOut, value: tint)
            .background(.tint.secondary)
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Toggle("Expand Details", systemImage: "chevron.down", isOn: $expanded)
        }
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = DisclosureGroups.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
        }
    }

    func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .textCase(.uppercase)
                .font(.caption)
                .bold()
                .foregroundStyle(.secondary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(.windowBackground, in: RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    DisclosureGroups()
}

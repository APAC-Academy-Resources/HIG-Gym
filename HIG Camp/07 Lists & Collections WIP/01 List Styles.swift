//
//  01 List Styles.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct ListStyles: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "List styles",
        description: "A List's style controls its grouping, insets and separators — plain, grouped or inset grouped. Sections add headers and footers. Switch the style from the bottom bar.",
        systemImage: "list.bullet"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var style: ListStyleOption = .insetGrouped
    @State private var tint: Color = ListStyles.getRandomColor()

    let recents = ["Inbox", "Drafts", "Sent", "Archive"]

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
            List {
                Section {
                    infoCard
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                Section {
                    Label("All Mail", systemImage: "tray.full")
                    Label("Flagged", systemImage: "flag")
                    Label("Unread", systemImage: "envelope.badge")
                } header: {
                    Text("Favorites")
                } footer: {
                    Text("Headers and footers describe the rows in their section.")
                }

                Section("Recents") {
                    ForEach(recents, id: \.self) { name in
                        Label(name, systemImage: "clock")
                    }
                }
            }
            .listStyleOption(style)
            .navigationTitle("List Styles")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                toolbar
            }
            .animation(.easeInOut, value: tint)
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = ListStyles.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
        }
        ToolbarSpacer(.flexible, placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
            Picker("List Style", selection: $style) {
                ForEach(ListStyleOption.allCases) { option in
                    Text(option.label).tag(option)
                }
            }
            .pickerStyle(.menu)
            .fixedSize()
        }
    }
}

#Preview {
    ListStyles()
}

// MARK: - List Style Picker
enum ListStyleOption: String, CaseIterable, Identifiable {
    case plain
    case grouped
    case insetGrouped
    case inset
    case sidebar

    var id: Self { self }

    var label: String {
        switch self {
        case .plain: "Plain"
        case .grouped: "Grouped"
        case .insetGrouped: "Inset Grouped"
        case .inset: "Inset"
        case .sidebar: "Sidebar"
        }
    }
}

extension View {
    /// Applies the concrete `ListStyle` matching the chosen option.
    @ViewBuilder
    func listStyleOption(_ option: ListStyleOption) -> some View {
        switch option {
        case .plain: listStyle(.plain)
        case .grouped: listStyle(.grouped)
        case .insetGrouped: listStyle(.insetGrouped)
        case .inset: listStyle(.inset)
        case .sidebar: listStyle(.sidebar)
        }
    }
}

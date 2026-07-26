//
//  01 List Styles.swift
//  HIG Camp
//

import SwiftUI

struct ListStylesDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "List styles",
        description: "A List's style controls its grouping, insets and separators — plain, grouped or inset grouped. Sections add headers and footers. Switch the style from the bottom bar.",
        systemImage: "list.bullet"
    )

    // MARK: - State
    @State private var style: ListStyleOption = .insetGrouped
    @State private var tint: Color = .demoRandom
    @State private var isDarkMode = false

    private let recents = ["Inbox", "Drafts", "Sent", "Archive"]

    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                Section {
                    infoCard
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden, edges: .all)
                } header: {
                    Text("About this demo")
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

                Section {
                    ForEach(recents, id: \.self) { name in
                        Label(name, systemImage: "clock")
                    }
                } header: {
                    Text("Recents")
                } footer: {
                    caption("`.listStyle(_:)` picks the grouping, insets and separators for the whole `List`.")
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
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Tint", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = .demoRandom
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $isDarkMode)
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
    ListStylesDemo()
}

// MARK: - Options
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

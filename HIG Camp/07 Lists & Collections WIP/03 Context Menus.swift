//
//  03 Context Menus.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct ContextMenus: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Context menus",
        description: "contextMenu attaches a menu revealed by a long press. It can show a custom preview, and a Menu button presents the same kind of menu on tap (see DemoMenuView).",
        systemImage: "contextualmenu.and.cursorarrow"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var tint: Color = ContextMenus.getRandomColor()

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

                    section("Long-press for a context menu") {
                        card("Bali Sunset", systemImage: "photo")
                            .contextMenu {
                                menuItems
                            }
                    }

                    section("Context menu with a preview") {
                        card("Bali Sunset", systemImage: "photo")
                            .contextMenu {
                                menuItems
                            } preview: {
                                Image(.bali)
                                    .resizable()
                                    .scaledToFit()
                            }
                    }

                    section("Menu button (DemoMenuView)") {
                        DemoMenuView()
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Context Menus")
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
    @ViewBuilder
    var menuItems: some View {
        Button("Open", systemImage: "arrow.up.forward.app") {}
        Button("Share", systemImage: "square.and.arrow.up") {}
        Divider()
        Button("Delete", systemImage: "trash", role: .destructive) {}
    }

    func card(_ title: String, systemImage: String) -> some View {
        HStack {
            Image(systemName: systemImage)
                .font(.largeTitle)
                .foregroundStyle(.tint)
            Text(title)
                .font(.title3)
            Spacer()
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = ContextMenus.getRandomColor()
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
    ContextMenus()
}

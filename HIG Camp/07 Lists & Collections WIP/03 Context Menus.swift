//
//  03 Context Menus.swift
//  HIG Camp
//

import SwiftUI

struct ContextMenusDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Context menus",
        description: "contextMenu attaches a menu revealed by a long press. It can show a custom preview, and a Menu button presents the same kind of menu on tap (see DemoMenuView).",
        systemImage: "contextualmenu.and.cursorarrow"
    )

    // MARK: - Body
    var body: some View {
        DemoPage("Context Menus", info: infoCard) { _ in
            DemoSection("Long-press for a context menu") {
                card("Bali Sunset", systemImage: "photo")
                    .contextMenu {
                        menuItems
                    }
                caption("`.contextMenu` attaches actions revealed by a long press.")
            }

            DemoSection("Context menu with a preview") {
                card("Bali Sunset", systemImage: "photo")
                    .contextMenu {
                        menuItems
                    } preview: {
                        Image(.bali)
                            .resizable()
                            .scaledToFit()
                    }
                caption("The `preview:` closure replaces the blurred snapshot with your own view.")
            }

            DemoSection("Menu button") {
                DemoMenuView()
                caption("A `Menu` shows the same kind of list of actions, but on a plain tap.")
            }
        }
    }

    // MARK: - View Components
    @ViewBuilder
    private var menuItems: some View {
        Button("Open", systemImage: "arrow.up.forward.app") {}
        Button("Share", systemImage: "square.and.arrow.up") {}
        Divider()
        Button("Delete", systemImage: "trash", role: .destructive) {}
    }

    private func card(_ title: String, systemImage: String) -> some View {
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
}

#Preview {
    ContextMenusDemo()
}

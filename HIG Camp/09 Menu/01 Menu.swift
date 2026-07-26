//
//  01 Menu.swift
//  HIG Camp
//

import SwiftUI

struct MenuDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Menus",
        description: "Menu presents a list of actions on tap",
        systemImage: "filemenu.and.selection"
    )

    // MARK: - State
    enum SortOrder: String, CaseIterable, Identifiable {
        case name, date, size
        var id: Self { self }
        var label: String { rawValue.capitalized }
        var symbol: String {
            switch self {
            case .name: "textformat"
            case .date: "calendar"
            case .size: "arrow.up.arrow.down"
            }
        }
    }

    @State private var lastAction: String = "—"
    @State private var primaryTaps: Int = 0
    @State private var sort: SortOrder = .name
    @State private var favorite: Bool = false
    @State private var fixedOrder: Bool = false

    // MARK: - Body
    var body: some View {
        DemoPage("Menu", info: infoCard) { _ in
            DemoSection("Basic") {
                Menu("Actions") {
                    Button("Copy", systemImage: "doc.on.doc") { lastAction = "Copy" }
                    Button("Duplicate", systemImage: "plus.square.on.square") { lastAction = "Duplicate" }
                    Button("Delete", systemImage: "trash", role: .destructive) { lastAction = "Delete" }
                }
                .buttonStyle(.borderedProminent)
                Text("Last action: \(lastAction)")
                    .font(.callout)
                    .foregroundStyle(.tint)
                caption("`Menu` shows its buttons on tap; every button on this page reports here.")
            }

            DemoSection("Primary action") {
                HStack {
                    Menu {
                        Button("Add 5", systemImage: "5.arrow.trianglehead.clockwise") { primaryTaps += 5 }
                        Button("Add 10", systemImage: "10.arrow.trianglehead.clockwise") { primaryTaps += 10 }
                    } label: {
                        Label("Add", systemImage: "plus")
                    } primaryAction: {
                        primaryTaps += 1
                    }
                    .buttonStyle(.borderedProminent)

                    Text("\(primaryTaps)")
                }
                Text("Tap runs the action, long-press opens the menu.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            DemoSection("Picker") {
                Menu {
                    Picker("Sort by", selection: $sort) {
                        ForEach(SortOrder.allCases) { order in
                            Label(order.label, systemImage: order.symbol).tag(order)
                        }
                    }
                    Toggle("Favorites only", systemImage: "star", isOn: $favorite)
                } label: {
                    Label("Sort: \(sort.label)", systemImage: sort.symbol)
                }
                .buttonStyle(.borderedProminent)
                Text("Favorites only: \(favorite ? "On" : "Off")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            DemoSection("Control group") {
                Menu("Format") {
                    ControlGroup {
                        Button("Bold", systemImage: "bold") { lastAction = "Bold" }
                        Button("Italic", systemImage: "italic") { lastAction = "Italic" }
                        Button("Underline", systemImage: "underline") { lastAction = "Underline" }
                    }
                    Button("Clear", systemImage: "eraser") { lastAction = "Clear" }
                }
                .buttonStyle(.borderedProminent)
                caption("`ControlGroup` packs its buttons into one compact row inside the menu.")
            }

            DemoSection("Sections & submenu") {
                DemoMenuView()
                    .buttonStyle(.borderedProminent)
                caption("A nested `Menu` becomes a submenu, and `Divider` splits items into groups.")
            }

            DemoSection("Order & style") {
                Toggle("Fixed order", isOn: $fixedOrder)
                Menu("Ordered menu") {
                    Button("First") { lastAction = "First" }
                    Button("Second") { lastAction = "Second" }
                    Button("Third") { lastAction = "Third" }
                }
                .menuOrder(fixedOrder ? .fixed : .priority)
                .menuStyle(.button)
                .buttonStyle(.borderedProminent)
                Text(".priority mirrors items toward the anchor; .fixed keeps source order.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    MenuDemo()
}

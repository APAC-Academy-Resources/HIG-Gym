//
//  01 Menu.swift
//  HIG Camp
//
//  Created by George Ananda on 07/07/26.
//

import SwiftUI

struct MenuDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Menus",
        description: "Menu presents a list of actions on tap",
        systemImage: "filemenu.and.selection"
    )

    // MARK: - Properties & Methods
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

    @State private var darkModeOn: Bool = false
    @State private var lastAction: String = "—"
    @State private var primaryTaps: Int = 0
    @State private var sort: SortOrder = .name
    @State private var favorite: Bool = false
    @State private var fixedOrder: Bool = false
    @State private var tint: Color = MenuDemo.getRandomColor()

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

                    section("Basic") {
                        Menu("Actions") {
                            Button("Copy", systemImage: "doc.on.doc") { lastAction = "Copy" }
                            Button("Duplicate", systemImage: "plus.square.on.square") { lastAction = "Duplicate" }
                            Button("Delete", systemImage: "trash", role: .destructive) { lastAction = "Delete" }
                        }
                        .buttonStyle(.borderedProminent)
                    }

                    section("Primary action") {
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

                    section("Picker") {
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

                    section("Control group") {
                        Menu("Format") {
                            ControlGroup {
                                Button("Bold", systemImage: "bold") { lastAction = "Bold" }
                                Button("Italic", systemImage: "italic") { lastAction = "Italic" }
                                Button("Underline", systemImage: "underline") { lastAction = "Underline" }
                            }
                            Button("Clear", systemImage: "eraser") { lastAction = "Clear" }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    section("Sections & submenu") {
                        DemoMenuView()
                            .buttonStyle(.borderedProminent)
                    }

                    section("Order & style") {
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
            .background(.tint.secondary)
            .contentMargins(16)
            .navigationTitle("Menu")
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
                tint = MenuDemo.getRandomColor()
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
    MenuDemo()
}

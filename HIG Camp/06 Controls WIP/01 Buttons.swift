//
//  01 Buttons.swift
//  HIG Camp
//

import SwiftUI

struct ButtonsDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Button styles & roles",
        description: "Buttons adapt to their style, control size, role and tint. Toggle the disabled switch and randomize the tint using the toolbar to see how every style responds.",
        systemImage: "hand.tap.fill"
    )

    // MARK: - State
    @State private var isDisabled: Bool = false
    @State private var pageButtonStyle: ButtonStyleOption = .borderedProminent
    @State private var pastedString = ""

    // MARK: - Body
    var body: some View {
        DemoPage("Buttons", info: infoCard, toolbar: {
            ToolbarItem(placement: .primaryAction) {
                Toggle("Disabled", systemImage: "nosign", isOn: $isDisabled)
            }
            ToolbarSpacer(.flexible, placement: .bottomBar)
            ToolbarItem(placement: .bottomBar) {
                Picker("Button Style", selection: $pageButtonStyle) {
                    ForEach(ButtonStyleOption.allCases) { style in
                        Text(style.label).tag(style)
                    }
                }
                .pickerStyle(.menu)
                .fixedSize()
            }
        }) { _ in
            Group {
                buttonStyles

                DemoSection("Control Sizes") {
                    HStack {
                        Button("Small") {}
                            .controlSize(.small)

                        Button("Small Flexible") {}
                            .controlSize(.small)
                            .buttonSizing(.flexible)
                    }
                    HStack {
                        Button("Regular") {}
                            .controlSize(.regular)

                        Button("Regular Flexible") {}
                            .controlSize(.regular)
                            .buttonSizing(.flexible)
                    }
                    HStack {
                        Button("Large") {}
                            .controlSize(.large)

                        Button("Large Flexible") {}
                            .controlSize(.large)
                            .buttonSizing(.flexible)
                    }
                    caption("`.controlSize(_:)` scales the whole control, not just its label; `.buttonSizing(.flexible)` lets it stretch to fill the space it is offered.")
                }
                .primitiveButtonStyle(pageButtonStyle)

                DemoSection("Roles") {
                    Grid(alignment: .leading) {
                        GridRow {
                            Text("Cancel")
                                .foregroundStyle(.secondary)
                            Button(role: .cancel) {}
                                .gridColumnAlignment(.center)
                        }
                        Divider()
                        GridRow {
                            Text("Close")
                                .foregroundStyle(.secondary)
                            Button(role: .close) {}
                        }
                        Divider()
                        GridRow {
                            Text("Confirm")
                                .foregroundStyle(.secondary)
                            Button(role: .confirm) {}
                        }
                        Divider()
                        GridRow {
                            Text("Destructive")
                                .foregroundStyle(.secondary)
                            Button(role: .destructive) {}
                        }
                        Divider()
                            .padding(.bottom)
                        Text("The button roles determine the labels of each button.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .primitiveButtonStyle(pageButtonStyle)

                DemoSection("Button labels") {
                    Grid(alignment: .leading, verticalSpacing: 12) {
                        GridRow {
                            Text("Title & icon")
                                .foregroundStyle(.secondary)
                            Button("Add", systemImage: "plus") {}
                                .gridColumnAlignment(.center)
                        }
                        Divider()
                        GridRow {
                            Text("Icon only")
                                .foregroundStyle(.secondary)
                            Button("Add", systemImage: "plus") {}
                                .labelStyle(.iconOnly)
                        }
                        Divider()
                        GridRow {
                            Text("Title only")
                                .foregroundStyle(.secondary)
                            Button("Add", systemImage: "plus") {}
                                .labelStyle(.titleOnly)
                        }
                        Divider()
                        GridRow {
                            Text("Custom label")
                                .foregroundStyle(.secondary)
                            Button {
                            } label: {
                                Text("Favorite")
                                    .foregroundStyle(LinearGradient(colors: [.white, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .bold()
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                            }
                        }
                        Divider()
                            .padding(.bottom)
                        Text("Pass a `systemImage` to the title initializer, or build a `Label` for full control. Use `.labelStyle(.iconOnly)` to hide the title.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .primitiveButtonStyle(pageButtonStyle)

                DemoSection("System buttons") {
                    Grid(alignment: .leading, verticalSpacing: 12) {
                        GridRow {
                            Text("Edit Button")
                            EditButton()
                        }
                        Divider()
                        GridRow {
                            Text("Rename Button")
                            RenameButton()
                        }
                        Divider()
                        GridRow {
                            Text("Paste Button \(self.pastedString)")
                            PasteButton(payloadType: String.self) { strings in
                                pastedString = strings[0]
                            }
                        }
                    }
                    caption("`EditButton`, `RenameButton` and `PasteButton` are system-supplied — they carry their own title, action and, for paste, the privacy-safe pasteboard access.")
                }
            }
            .disabled(isDisabled)
        }
    }

    // MARK: - View Components
    private var buttonStyles: some View {
        TabView {
            Tab {
                buttonPage
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal)
            }
            Tab {
                buttonPage
                    .background(.ultraThinMaterial)
                    .background(.tint.tertiary)
                    .background {
                        Image(.bali)
                            .resizable()
                            .scaledToFill()
                            .blur(radius: 6)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal)

            }
            Tab {
                buttonPage
                    .background {
                        Image(.bali)
                            .resizable()
                            .scaledToFill()
                            .blur(radius: 6)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal)

            }
            Tab {
                buttonPage
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal)
            }
            Tab {
                buttonPage
                    .background(
                        LinearGradient(
                            colors: [
                                .red,
                                .orange,
                                .pink
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        in: RoundedRectangle(cornerRadius: 24)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal)
            }
        }
        .tabViewStyle(.page)
        .padding(.horizontal, -16)
        .frame(height: 400)
        .overlay {
            VStack {
                Button("Plain Button") {}
                    .buttonStyle(.plain)
                Button("Bordered Button") {}
                    .buttonStyle(.bordered)
                Button("Bordered Prominent Button") {}
                    .buttonStyle(.borderedProminent)
                Button("Glass Prominent Button") {}
                    .buttonStyle(.glassProminent)
                Button("Regular Glass Button") {}
                    .buttonStyle(.glass)
                Button("Clear Glass Button") {}
                    .buttonStyle(.glass(.clear))
            }
        }
    }

    private var buttonPage: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundStyle(.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: 48)
                    .foregroundStyle(.ultraThinMaterial)
                    .background(.tint.tertiary)
            }
    }
}

// MARK: - Options
enum ButtonStyleOption: String, CaseIterable, Identifiable {
    case automatic
    case plain
    case borderless
    case bordered
    case borderedProminent
    case glass
    case glassClear
    case glassProminent

    var id: Self { self }

    var label: String {
        switch self {
        case .automatic: "Automatic"
        case .plain: "Plain"
        case .borderless: "Borderless"
        case .bordered: "Bordered"
        case .borderedProminent: "Bordered Prominent"
        case .glass: "Glass"
        case .glassClear: "Glass Clear"
        case .glassProminent: "Glass Prominent"
        }
    }
}

extension View {
    /// Applies the concrete `PrimitiveButtonStyle` matching the chosen option.
    @ViewBuilder
    func primitiveButtonStyle(_ option: ButtonStyleOption) -> some View {
        switch option {
        case .automatic: buttonStyle(.automatic)
        case .plain: buttonStyle(.plain)
        case .borderless: buttonStyle(.borderless)
        case .bordered: buttonStyle(.bordered)
        case .borderedProminent: buttonStyle(.borderedProminent)
        case .glass: buttonStyle(.glass)
        case .glassClear: buttonStyle(.glass(.clear))
        case .glassProminent: buttonStyle(.glassProminent)
        }
    }
}

#Preview {
    ButtonsDemo()
}

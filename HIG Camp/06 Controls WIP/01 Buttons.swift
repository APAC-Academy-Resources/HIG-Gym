//
//  01 Buttons.swift
//  HIG Camp
//
//  Created by George Ananda on 21/06/26.
//

import SwiftUI

struct Buttons: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Button styles & roles",
        description: "Buttons adapt to their style, control size, role and tint. Toggle the disabled switch and randomize the tint using the toolbar to see how every style responds.",
        systemImage: "hand.tap.fill"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var isDisabled: Bool = false
    @State private var tint: Color = Buttons.getRandomColor()
    @State private var pageButtonStyle: ButtonStyleOption = .bordered
    
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

                    buttonStyles

                    section("Control Sizes") {
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
                    }
                    .primitiveButtonStyle(pageButtonStyle)

                    section("Roles") {
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
                }
                .disabled(isDisabled)
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Buttons")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                toolbar
            }
            .animation(.easeInOut, value: tint)
            .background(.tint.opacity(0.5))
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    var buttonStyles: some View {
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
    
    var buttonPage: some View {
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

    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Toggle("Disabled", systemImage: "nosign", isOn: $isDisabled)
        }
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = Buttons.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
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
    }

    func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .textCase(.uppercase)
                .font(.caption)
                .bold()
                .foregroundStyle(.secondary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    Buttons()
}

// MARK: - Button Style Picker
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

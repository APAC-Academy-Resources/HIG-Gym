//
//  06 Control Group.swift
//  HIG Camp
//
//  Created by George Ananda on 21/06/26.
//

import SwiftUI

struct ControlGroupDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Control Groups",
        description: "Semantically groups controls. The system determines its appearance based on where it is placed (e.g in a form, menu, or by itself",
        systemImage: "rectangle.3.group"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var progress: Double = 0.4
    @State private var tint: Color = ProgressDemo.getRandomColor()
    @State private var selectedPicker: Int = 0

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

                    section("As a view") {
                        buttonsGroup("Automatic").controlGroupStyle(.automatic)
                        buttonsGroup("Navigation").controlGroupStyle(.navigation)
                        buttonsGroup("Menu").controlGroupStyle(.menu)
                        buttonsGroup("Compact Menu").controlGroupStyle(.compactMenu)
                    }

                    section("In Menu") {
                        Menu("Menu with automatic control group", systemImage: "filemenu.and.selection") {
                            Text("This is a menu containing a control group")

                            buttonsGroup("Control Group").controlGroupStyle(.automatic)
                        }
                    }
                    
                    section("In Form") {
                        NavigationLink {
                            Form {
                                ControlGroup("Control Group: Automatic") {
                                    Text("This is a control group containing a picker and a toggle")
                                    Picker(selection: $selectedPicker) {
                                        Text("Red").tag(0)
                                        Text("Yellow").tag(1)
                                        Text("Blue").tag(2)
                                    } label: {
                                        Text("Sample Picker")
                                    }
                                    .pickerStyle(.menu)
                                   
                                    Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
                                    
                                }
                            }
                            .navigationTitle("Controls")
                            .toolbarTitleDisplayMode(.inline)
                        } label: {
                            Text("Open form")
                        }

                    }
                    
                    section("In Toolbar") {
                        Image(systemName: "arrow.down")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Control Groups")
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
    func buttonsGroup(_ label: String) -> some View {
        ControlGroup(label) {
            Button("Cut", systemImage: "scissors") {
            }
            Button("Copy", systemImage: "document.on.document") {
            }
            Button("Paste", systemImage: "clipboard") {
            }
        }
    }
    
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = ProgressDemo.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
        }
        ToolbarItem(placement: .bottomBar) {
            buttonsGroup("In toolbar")
                .controlGroupStyle(.automatic)
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
    ControlGroupDemo()
}

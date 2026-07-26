//
//  06 Control Group.swift
//  HIG Camp
//

import SwiftUI

struct ControlGroupDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Control Groups",
        description: "Semantically groups controls. The system determines its appearance based on where it is placed (e.g in a form, menu, or by itself",
        systemImage: "rectangle.3.group"
    )

    // MARK: - State
    @State private var selectedPicker: Int = 0
    @State private var formToggleOn: Bool = false

    // MARK: - Body
    var body: some View {
        DemoPage("Control Groups", info: infoCard, toolbar: {
            ToolbarItem(placement: .bottomBar) {
                buttonsGroup("In toolbar")
                    .controlGroupStyle(.automatic)
            }
        }) { _ in
            DemoSection("As a view") {
                buttonsGroup("Automatic").controlGroupStyle(.automatic)
                buttonsGroup("Navigation").controlGroupStyle(.navigation)
                buttonsGroup("Menu").controlGroupStyle(.menu)
                buttonsGroup("Compact Menu").controlGroupStyle(.compactMenu)
                caption("`.controlGroupStyle(_:)` picks the presentation: a row of buttons, a navigation bar cluster, or a single menu button.")
            }

            DemoSection("In Menu") {
                Menu("Menu with automatic control group", systemImage: "filemenu.and.selection") {
                    Text("This is a menu containing a control group")

                    buttonsGroup("Control Group").controlGroupStyle(.automatic)
                }
                caption("Inside a `Menu`, `.automatic` renders the group as one compact row of icons rather than separate rows.")
            }

            DemoSection("In Form") {
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

                            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $formToggleOn)

                        }
                    }
                    .navigationTitle("Controls")
                    .toolbarTitleDisplayMode(.inline)
                } label: {
                    Text("Open form")
                }
                caption("In a `Form` the group becomes a labelled section — same code, container-driven appearance.")
            }

            DemoSection("In Toolbar") {
                Image(systemName: "arrow.down")
                .frame(maxWidth: .infinity)
                .foregroundStyle(.secondary)
                caption("The same `ControlGroup` in the bottom bar below collapses into toolbar-sized controls.")
            }
        }
    }

    // MARK: - View Components
    private func buttonsGroup(_ label: String) -> some View {
        ControlGroup(label) {
            Button("Cut", systemImage: "scissors") {
            }
            Button("Copy", systemImage: "document.on.document") {
            }
            Button("Paste", systemImage: "clipboard") {
            }
        }
    }
}

#Preview {
    ControlGroupDemo()
}

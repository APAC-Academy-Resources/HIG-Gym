//
//  01 Alerts.swift
//  HIG Camp
//

import SwiftUI

struct AlertsDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Alerts",
        description: "alert(_:isPresented:) presents a modal alert. Its buttons carry roles (.destructive, .cancel) that style and order them, and it can host text fields for quick input.",
        systemImage: "exclamationmark.triangle"
    )

    // MARK: - State
    @State private var showSimple: Bool = false
    @State private var showRoles: Bool = false
    @State private var showTextField: Bool = false
    @State private var name: String = ""

    // MARK: - Body
    var body: some View {
        DemoPage("Alerts", info: infoCard) { _ in
            DemoSection("Simple") {
                Button("Show Alert") { showSimple = true }
                    .buttonStyle(.borderedProminent)
                    .alert("Saved", isPresented: $showSimple) {
                        Button("OK") {}
                    } message: {
                        Text("Your changes have been saved.")
                    }
                caption("`.alert(_:isPresented:)` drives a modal alert from a `Bool` binding.")
            }

            DemoSection("Roles") {
                Button("Delete Item") { showRoles = true }
                    .buttonStyle(.borderedProminent)
                    .alert("Delete Item?", isPresented: $showRoles) {
                        Button(role: .destructive) {}
                        Button(role: .cancel) {}
                    } message: {
                        Text("This action cannot be undone.")
                    }
                caption("A `role:` supplies the button's title, colour and position — no label needed.")
            }

            DemoSection("With a text field") {
                Button("Rename") { showTextField = true }
                    .buttonStyle(.borderedProminent)
                    .alert("Rename", isPresented: $showTextField) {
                        TextField("Name", text: $name)
                        Button(role: .confirm) {}
                        Button(role: .cancel) {}
                    } message: {
                        Text("Enter a new name for this item.")
                    }
                if !name.isEmpty {
                    Text("Saved name: \(name)")
                        .foregroundStyle(.tint)
                }
                caption("An alert can host a `TextField` for one short piece of input.")
            }
        }
    }
}

#Preview {
    AlertsDemo()
}

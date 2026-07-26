//
//  02 ConfirmationDialog.swift
//  HIG Camp
//

import SwiftUI

struct ConfirmationDialogDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Confirmation dialogs",
        description: "confirmationDialog presents an action sheet of choices anchored to the bottom on iPhone. It suits a short list of mutually exclusive actions, with titleVisibility controlling the header.",
        systemImage: "square.stack.3d.up"
    )

    // MARK: - State
    @State private var showActions: Bool = false
    @State private var showTitled: Bool = false
    @State private var choice: String = "—"

    // MARK: - Body
    var body: some View {
        DemoPage("Confirmation Dialog", info: infoCard) { _ in
            DemoSection("Actions") {
                Button("Show Options") { showActions = true }
                    .buttonStyle(.borderedProminent)
                    .confirmationDialog("Choose an action", isPresented: $showActions) {
                        Button("Camera") { choice = "Camera" }
                        Button("Photo Library") { choice = "Photo Library" }
                        Button("Files") { choice = "Files" }
                        Button("Cancel", role: .cancel) { choice = "Cancel" }
                    }
                Text("Last choice: \(choice)")
                    .foregroundStyle(.tint)
                caption("`.confirmationDialog(_:isPresented:)` slides a short list of actions up from the bottom.")
            }

            DemoSection("Visible title") {
                Button("Delete Photo") { showTitled = true }
                    .buttonStyle(.borderedProminent)
                    .confirmationDialog(
                        "Delete this photo?",
                        isPresented: $showTitled,
                        titleVisibility: .visible
                    ) {
                        Button("Delete", role: .destructive) {}
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("This photo will be removed from all devices.")
                    }
                caption("`titleVisibility: .visible` shows the title as a header above the actions.")
            }
        }
    }
}

#Preview {
    ConfirmationDialogDemo()
}

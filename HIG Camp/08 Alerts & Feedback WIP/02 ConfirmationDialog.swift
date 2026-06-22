//
//  02 ConfirmationDialog.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct ConfirmationDialogDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Confirmation dialogs",
        description: "confirmationDialog presents an action sheet of choices anchored to the bottom on iPhone. It suits a short list of mutually exclusive actions, with titleVisibility controlling the header.",
        systemImage: "square.stack.3d.up"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var showActions: Bool = false
    @State private var showTitled: Bool = false
    @State private var choice: String = "—"
    @State private var tint: Color = ConfirmationDialogDemo.getRandomColor()

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

                    section("Actions") {
                        Button("Show Options") { showActions = true }
                            .buttonStyle(.borderedProminent)
                        Text("Last choice: \(choice)")
                            .foregroundStyle(.tint)
                    }

                    section("Visible title") {
                        Button("Delete Photo") { showTitled = true }
                            .buttonStyle(.borderedProminent)
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Confirmation Dialog")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                toolbar
            }
            .animation(.easeInOut, value: tint)
            .confirmationDialog("Choose an action", isPresented: $showActions) {
                Button("Camera") { choice = "Camera" }
                Button("Photo Library") { choice = "Photo Library" }
                Button("Files") { choice = "Files" }
                Button("Cancel", role: .cancel) { choice = "Cancel" }
            }
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
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = ConfirmationDialogDemo.getRandomColor()
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
    ConfirmationDialogDemo()
}

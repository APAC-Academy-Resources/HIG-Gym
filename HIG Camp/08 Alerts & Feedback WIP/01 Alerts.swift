//
//  01 Alerts.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct Alerts: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Alerts",
        description: "alert(_:isPresented:) presents a modal alert. Its buttons carry roles (.destructive, .cancel) that style and order them, and it can host text fields for quick input.",
        systemImage: "exclamationmark.triangle"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var showSimple: Bool = false
    @State private var showRoles: Bool = false
    @State private var showTextField: Bool = false
    @State private var name: String = ""
    @State private var tint: Color = Alerts.getRandomColor()

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

                    section("Simple") {
                        Button("Show Alert") { showSimple = true }
                            .buttonStyle(.borderedProminent)
                    }

                    section("Roles") {
                        Button("Delete Item") { showRoles = true }
                            .buttonStyle(.borderedProminent)
                    }

                    section("With a text field") {
                        Button("Rename") { showTextField = true }
                            .buttonStyle(.borderedProminent)
                        if !name.isEmpty {
                            Text("Saved name: \(name)")
                                .foregroundStyle(.tint)
                        }
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Alerts")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                toolbar
            }
            .animation(.easeInOut, value: tint)
            .background(.tint.secondary)
            .alert("Saved", isPresented: $showSimple) {
                Button("OK") {}
            } message: {
                Text("Your changes have been saved.")
            }
            .alert("Delete Item?", isPresented: $showRoles) {
                Button(role: .destructive) {}
                Button(role: .cancel) {}
            } message: {
                Text("This action cannot be undone.")
            }
            .alert("Rename", isPresented: $showTextField) {
                TextField("Name", text: $name)
                Button(role: .confirm) {}
                Button(role: .cancel) {}
            } message: {
                Text("Enter a new name for this item.")
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
                tint = Alerts.getRandomColor()
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
    Alerts()
}

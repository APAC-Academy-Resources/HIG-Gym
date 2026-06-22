//
//  03 Popovers.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct Popovers: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Popovers",
        description: "popover presents content anchored to its source. On compact iPhone widths it adapts to a sheet by default; presentationCompactAdaptation(.popover) keeps the popover look.",
        systemImage: "bubble.middle.top"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var showAdaptive: Bool = false
    @State private var showPopover: Bool = false
    @State private var tint: Color = Popovers.getRandomColor()

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

                    section("Default (adapts to a sheet)") {
                        Button("Show Popover") { showAdaptive = true }
                            .buttonStyle(.borderedProminent)
                            .popover(isPresented: $showAdaptive) {
                                popoverContent
                            }
                    }

                    section("Forced popover") {
                        Button("Show Popover") { showPopover = true }
                            .buttonStyle(.borderedProminent)
                            .popover(isPresented: $showPopover) {
                                popoverContent
                                    .presentationCompactAdaptation(.popover)
                            }
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Popovers")
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
    var popoverContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Profile", systemImage: "person")
            Label("Settings", systemImage: "gearshape")
            Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
        }
        .font(.title3)
        .padding(24)
    }

    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = Popovers.getRandomColor()
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
    Popovers()
}

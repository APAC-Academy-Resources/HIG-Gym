//
//  04 Pickers.swift
//  HIG Camp
//
//  Created by George Ananda on 21/06/26.
//

import SwiftUI

struct Pickers: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Pickers & DatePicker",
        description: "A Picker presents a set of mutually exclusive options; its picker style decides the presentation — segmented, menu, wheel or inline. DatePicker is a specialized picker for dates.",
        systemImage: "checklist"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var segment: Int = 0
    @State private var menuSelection: Int = 0
    @State private var wheelSelection: Int = 0
    @State private var inlineSelection: Int = 0
    @State private var date: Date = .distantPast
    @State private var tint: Color = Pickers.getRandomColor()

    let options = ["All", "Unread", "Flagged", "Drafts"]

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

                    section("Segmented") {
                        DemoPickerView(selectedSegment: $segment)
                            .pickerStyle(.segmented)
                    }

                    section("Menu") {
                        Picker("Filter", selection: $menuSelection) {
                            ForEach(options.indices, id: \.self) { index in
                                Text(options[index]).tag(index)
                            }
                        }
                        .pickerStyle(.menu)
                    }

                    section("Wheel") {
                        Picker("Filter", selection: $wheelSelection) {
                            ForEach(options.indices, id: \.self) { index in
                                Text(options[index]).tag(index)
                            }
                        }
                        .pickerStyle(.wheel)
                    }

                    section("Inline") {
                        Picker("Filter", selection: $inlineSelection) {
                            ForEach(options.indices, id: \.self) { index in
                                Text(options[index]).tag(index)
                            }
                        }
                        .pickerStyle(.inline)
                    }

                    section("DatePicker — Compact") {
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }

                    section("DatePicker — Graphical") {
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                }
                .padding(.vertical)
            }
            .contentMargins(16)
            .navigationTitle("Pickers")
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
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = Pickers.getRandomColor()
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
        .background(.background, in: RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    Pickers()
}

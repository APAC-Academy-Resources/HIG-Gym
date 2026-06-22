//
//  02 Swipe Actions.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct SwipeActionsDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Swipe actions",
        description: "swipeActions(edge:) attaches buttons revealed by swiping a row. Leading and trailing edges hold different actions; the first trailing button triggers on a full swipe unless allowsFullSwipe is false.",
        systemImage: "hand.draw"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var messages: [String] = (1...8).map { "Message \($0)" }
    @State private var tint: Color = SwipeActionsDemo.getRandomColor()

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
            List {
                Section {
                    infoCard
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                Section("Swipe a row") {
                    ForEach(messages, id: \.self) { message in
                        Label(message, systemImage: "envelope")
                            .swipeActions(edge: .leading) {
                                Button {
                                } label: {
                                    Label("Flag", systemImage: "flag")
                                }
                                .tint(.orange)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    messages.removeAll { $0 == message }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                Button {
                                } label: {
                                    Label("Archive", systemImage: "archivebox")
                                }
                                .tint(.indigo)
                            }
                    }
                }
            }
            .navigationTitle("Swipe Actions")
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
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Reset", systemImage: "arrow.counterclockwise") {
                messages = (1...8).map { "Message \($0)" }
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = SwipeActionsDemo.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
        }
    }
}

#Preview {
    SwipeActionsDemo()
}

//
//  02 Swipe Actions.swift
//  HIG Camp
//

import SwiftUI

struct SwipeActionsDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Swipe actions",
        description: "swipeActions(edge:) attaches buttons revealed by swiping a row. Leading and trailing edges hold different actions; the first trailing button triggers on a full swipe unless allowsFullSwipe is false.",
        systemImage: "hand.draw"
    )

    // MARK: - State
    private static let initialMessages = (1...8).map { "Message \($0)" }

    @State private var messages: [String] = initialMessages
    @State private var tint: Color = .demoRandom
    @State private var isDarkMode = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                Section {
                    infoCard
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                Section {
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
                } header: {
                    Text("Swipe a row")
                } footer: {
                    caption("`.swipeActions(edge:)` adds buttons revealed by dragging a row; `allowsFullSwipe` lets a long drag fire the first one.")
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
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Reset", systemImage: "arrow.counterclockwise") {
                messages = Self.initialMessages
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Tint", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = .demoRandom
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $isDarkMode)
        }
    }
}

#Preview {
    SwipeActionsDemo()
}

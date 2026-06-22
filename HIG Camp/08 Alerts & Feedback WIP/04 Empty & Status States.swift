//
//  04 Empty & Status States.swift
//  HIG Camp
//
//  Created by George Ananda on 22/06/26.
//

import SwiftUI

struct EmptyAndStatusStates: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Empty & status states",
        description: "ContentUnavailableView communicates an empty result with an icon, title, description and optional actions. The built-in .search variant covers no-results, while a status enum drives loading, error and empty screens.",
        systemImage: "tray"
    )

    // MARK: - Properties & Methods
    @State private var darkModeOn: Bool = false
    @State private var status: StatusState = .empty
    @State private var tint: Color = EmptyAndStatusStates.getRandomColor()

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
            stateView
                .navigationTitle("Status States")
                .toolbarTitleDisplayMode(.inlineLarge)
                .toolbar {
                    toolbar
                }
                .animation(.easeInOut, value: tint)
                .animation(.easeInOut, value: status)
        }
        .tint(tint)
        .preferredColorScheme(darkModeOn ? .dark : .light)
    }

    // MARK: - View Components
    @ViewBuilder
    var stateView: some View {
        switch status {
        case .loading:
            ContentUnavailableView {
                ProgressView()
            } description: {
                Text("Loading your items…")
            }
        case .empty:
            ContentUnavailableView(
                "No Items",
                systemImage: "tray",
                description: Text("Items you add will appear here.")
            )
        case .search:
            ContentUnavailableView.search(text: "Bali")
        case .error:
            ContentUnavailableView {
                Label("Couldn't Load", systemImage: "wifi.exclamationmark")
            } description: {
                Text("Check your connection and try again.")
            } actions: {
                Button("Retry") { status = .loading }
                    .buttonStyle(.borderedProminent)
            }
        }
    }

    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Randomize Color", systemImage: "arrow.trianglehead.2.clockwise") {
                tint = EmptyAndStatusStates.getRandomColor()
            }
        }
        ToolbarItem(placement: .primaryAction) {
            Toggle("Dark Mode", systemImage: "moon.fill", isOn: $darkModeOn)
        }
        ToolbarSpacer(.flexible, placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
            Picker("State", selection: $status) {
                ForEach(StatusState.allCases) { state in
                    Text(state.label).tag(state)
                }
            }
            .pickerStyle(.menu)
            .fixedSize()
        }
    }
}

#Preview {
    EmptyAndStatusStates()
}

// MARK: - Status State
enum StatusState: String, CaseIterable, Identifiable {
    case loading
    case empty
    case search
    case error

    var id: Self { self }

    var label: String {
        switch self {
        case .loading: "Loading"
        case .empty: "Empty"
        case .search: "No Results"
        case .error: "Error"
        }
    }
}

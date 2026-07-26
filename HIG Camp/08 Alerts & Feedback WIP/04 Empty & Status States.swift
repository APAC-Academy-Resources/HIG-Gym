//
//  04 Empty & Status States.swift
//  HIG Camp
//

import SwiftUI

struct EmptyAndStatusStatesDemo: View {
    // MARK: - Info Card
    let infoCard = DemoInfoCard(
        title: "Empty & status states",
        description: "ContentUnavailableView communicates an empty result with an icon, title, description and optional actions. The built-in .search variant covers no-results, while a status enum drives loading, error and empty screens.",
        systemImage: "tray"
    )

    // MARK: - State
    @State private var status: StatusState = .empty

    // MARK: - Body
    var body: some View {
        DemoPage(
            "Empty & Status States",
            info: infoCard,
            toolbar: {
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
        ) { _ in
            DemoSection("ContentUnavailableView") {
                stateView
                    .animation(.easeInOut, value: status)
                caption("`ContentUnavailableView` states an empty result plainly — icon, title, description, optional actions.")
            }
        }
    }

    // MARK: - View Components
    @ViewBuilder
    private var stateView: some View {
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
}

// MARK: - Options
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

#Preview {
    EmptyAndStatusStatesDemo()
}

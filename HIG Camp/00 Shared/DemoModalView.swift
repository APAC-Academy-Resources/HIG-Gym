//
//  DemoModalView.swift
//  HIG Camp
//

import SwiftUI

/// A stand-in sheet body, used by the presentation demos.
///
/// Supply `isOpen` so the confirm/cancel buttons can close the sheet the same
/// way the presenting view opened it.
struct DemoModalView: View {
    /// Bound to the presenting view's presentation flag.
    @Binding var isOpen: Bool
    /// Shown as the navigation title. Ignored when `useMiniToolbar` is true.
    var title: String = "Sheet"
    /// Swaps the confirm/cancel pair for a single close button and hides the
    /// title — the compact treatment used by small detents.
    var useMiniToolbar: Bool = false

    var body: some View {
        NavigationStack {
            Text("Sheet Contents")
                .toolbarTitleDisplayMode(.inline)
                .navigationTitle(useMiniToolbar ? "" : title)
                .toolbar {
                    if useMiniToolbar {
                        miniToolbar
                    } else {
                        fullToolbar
                    }
                }
        }
    }

    // MARK: - View Components
    @ToolbarContentBuilder
    private var miniToolbar: some ToolbarContent {
        ToolbarItem {
            Button(role: .close) { isOpen = false }
        }
    }

    @ToolbarContentBuilder
    private var fullToolbar: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(role: .confirm) { isOpen = false }
        }
        ToolbarItem(placement: .cancellationAction) {
            Button(role: .cancel) { isOpen = false }
        }
        ToolbarSpacer(placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
            DemoMenuView()
        }
    }
}

#Preview("Full toolbar") {
    DemoModalView(isOpen: .constant(true))
}

#Preview("Mini toolbar") {
    DemoModalView(isOpen: .constant(true), useMiniToolbar: true)
}

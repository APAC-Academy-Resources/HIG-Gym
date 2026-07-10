import SwiftUI

struct DemoModalView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isOpen: Bool
    var title: String = "Sheet"
    var useMiniToolbar = false
    
    @ToolbarContentBuilder
    var miniToolbar: some ToolbarContent {
        ToolbarItem {
            Button(role: .close) {
                dismiss()
            }
        }
    }
    
    @ToolbarContentBuilder
    var fullToolbar: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(role: .confirm) {
                isOpen.toggle()
            }
        }
        ToolbarItem(placement: .cancellationAction) {
            Button(role: .cancel) {
                isOpen.toggle()
            }
        }
        ToolbarSpacer(placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
            DemoMenuView()
        }
    }

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
}

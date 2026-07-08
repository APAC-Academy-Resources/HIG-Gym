import SwiftUI

struct DemoModalView: View {
    @Binding var isOpen: Bool
    var title: String = "Sheet"

    var body: some View {
        NavigationStack {
            Text("Sheet Contents")
                .toolbarTitleDisplayMode(.inline)
                .navigationTitle(title)
                .toolbar {
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
        }
    }
}

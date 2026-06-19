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
                        Button("Ok", systemImage: "checkmark") {
                            isOpen.toggle()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", systemImage: "xmark") {
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

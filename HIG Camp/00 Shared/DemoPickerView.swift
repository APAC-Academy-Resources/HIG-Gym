import SwiftUI

struct DemoPickerView: View {
    var selectedSegment: Binding<Int>

    var body: some View {
        Picker("View", selection: selectedSegment) {
            Text("All").tag(0)
            Text("Unread").tag(1)
            Text("Flagged").tag(2)
        }
    }
}

#Preview {
    DemoPickerView(selectedSegment: .constant(1))
}

import SwiftUI

struct DemoRowView: View {
    let label: String

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.regularMaterial)
            .frame(height: 72)
            .overlay {
                HStack {
                    Text(label).padding(.leading)
                    Spacer()
                }
            }
    }
}

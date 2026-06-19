import SwiftUI

struct DemoRowView: View {
    let label: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundStyle(.primary)
                .font(.title3)
            HStack {
                Text("Secondary Info")
                    .foregroundStyle(.tint)
                Spacer()
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

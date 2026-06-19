//
//  ColorTest.swift
//  HIG Gym
//
//  Created by George Ananda on 19/06/26.
//

import SwiftUI

struct ColorTest: View {
    let customColor: Color = Color(hue: 0.5, saturation: 1, brightness: 0.5)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Hello Bay")
                        .foregroundStyle(.primary)
                    Text("Ini sekunder")
                        .foregroundStyle(.secondary)
                    Text("Ini tersier")
                        .foregroundStyle(.tertiary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                
                
                VStack(alignment: .leading) {
                    Text("Hello Bay")
                        .foregroundStyle(.primary)
                    Text("Ini sekunder")
                        .foregroundStyle(.secondary)
                    Text("Ini tersier")
                        .foregroundStyle(.tertiary)
                    Text("Ini quarternary")
                        .foregroundStyle(.quaternary)
                    Text("Ini quniary")
                        .foregroundStyle(.quinary)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}

#Preview {
    ColorTest()
}

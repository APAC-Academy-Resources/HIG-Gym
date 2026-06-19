//
//  VibrancyView.swift
//  HIG Camp
//
//  Created by George Ananda on 18/06/26.
//

import SwiftUI


struct VibrancyView: View {
    @State var pickerColor: Color = .red
    
    var sheet: some View {
        NavigationStack {
            VStack {
                ColorPicker("Tint Color", selection: $pickerColor)
            }
            .padding(.horizontal)
            .presentationDetents([.height(200)])
            .presentationBackgroundInteraction(.enabled)
            .interactiveDismissDisabled()
        }
    }
    
    var body: some View {
        NavigationStack {
            DemoScrollView(count: 24)
                .sheet(isPresented: .constant(true)) {
                    sheet
                        .background(.regularMaterial)
                }
        }
        .tint(pickerColor)
    }
}

#Preview {
    VibrancyView()
}

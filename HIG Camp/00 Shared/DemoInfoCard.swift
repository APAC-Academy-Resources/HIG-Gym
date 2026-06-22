//
//  DemoInfoCard.swift
//  HIG Camp
//
//  Created by George Ananda on 20/06/26.
//

import SwiftUI

struct DemoInfoCard: View {
    var title: String?
    let description: String
    var systemImage: String = "info.bubble"
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: systemImage)
                .foregroundStyle(.tint)
                .font(.largeTitle)
            
            VStack(alignment: .leading, spacing: 8) {
                if let title = title {
                    Text(title)
                        .font(.title3)
                        .bold()
                }
                Text(description)
                    .font(.default)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 24)
        .background(.windowBackground, in: RoundedRectangle(cornerRadius: 24))
    }
}


//
//  FeelingHistoryCellView.swift
//  Soup
//
//  Created by Максим Алексеев  on 06.04.2025.
//

import SwiftUI

struct FeelingHistoryCellView: View {
    let feeling: Feeling
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(feeling.colorScheme.primary)
                    .frame(width: 90, height: 90)
                
                Text(feeling.emojiText)
                    .font(.system(size: 70))
            }
            .padding(.vertical, 10)
            .padding(.leading, 10)
            
            VStack(alignment: .leading, spacing: .zero) {
                Text("PartnerName felt")
                    .foregroundStyle(AppColors.Common.secondary)
                    .font(.system(size: 16, weight: .semibold))
                
                Text(feeling.name.capitalized)
                    .foregroundStyle(AppColors.Common.dark)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 5)
                
                Text("10:00")
                    .foregroundStyle(AppColors.Common.secondary)
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ZStack {
        Feeling.angry.colorScheme.background .ignoresSafeArea(.all)
        FeelingHistoryCellView(feeling:   .angry)
    }
}

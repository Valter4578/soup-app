//
//  FeelingHistoryCellView.swift
//  Soup
//
//  Created by Максим Алексеев  on 06.04.2025.
//

import SwiftUI

struct FeelingHistoryCellView: View {
    let feelingResponse: FeelingResponse
    let formattedTimeString: String
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(feelingResponse.feeling.colorScheme.primary)
                    .frame(width: 90, height: 90)

                Text(feelingResponse.feeling.emojiText)
                    .font(.system(size: 70))
            }
            .padding(.vertical, 10)
            .padding(.leading, 10)

            VStack(alignment: .leading, spacing: .zero) {
                Text("PartnerName felt")
                    .foregroundStyle(AppColors.Common.secondary)
                    .font(.system(size: 16, weight: .semibold))

                Text(feelingResponse.feeling.name.capitalized)
                    .foregroundStyle(AppColors.Common.dark)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 5)

                Text(formattedTimeString)
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
        Feeling.angry.colorScheme.background.ignoresSafeArea(.all)
        FeelingHistoryCellView(feelingResponse: FeelingResponse(id: UUID(), feeling: .angry, timestamp: 1745149729458), formattedTimeString: "10:10")
    }
}

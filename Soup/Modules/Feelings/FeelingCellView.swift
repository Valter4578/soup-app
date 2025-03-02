//
//  FeelingCellView.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import SwiftUI

struct FeelingCellView: View {
    let feeling: Feeling
    var body: some View {
        VStack(spacing: 5) {
            Text(feeling.emojiText)
                .font(.system(size: 80))
                
            Text("I feel \(feeling.name.lowercased())")
                .foregroundStyle(.white)
                .font(.system(size: 16, weight: .bold))
        }
        .frame(width: 174, height: 144)
        .background(feeling.color)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ZStack {
        FeelingCellView(feeling: Feeling(name: "Happy", emojiText: "😊", color: .yellow))
    }
}

//
//  TabLabelView.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI

import SwiftUI

let BTTN_HEIGHT: CGFloat = 32
let CORNER_RADIUS: CGFloat = 50

struct ActiveTabLabel: View {
    @Environment(ThemeManager.self) private var themeManager
    let tabItem: TabBarItem

    var body: some View {
        ZStack {
            HStack(spacing: 6) {
                Image(tabItem.imageName)
                    .renderingMode(.template)
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                
                Text(tabItem.title)
                    .foregroundStyle(.white)
                    .font(.system(size: 17))
                    .lineLimit(1)
                    .fixedSize()
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .background(themeManager.currentScheme.gradient)
            .clipShape(RoundedRectangle(cornerRadius: CORNER_RADIUS))
        }
    }
}

struct InActiveTabLabel: View {
    let tabItem: TabBarItem
    
    var body: some View {
        ZStack {
            HStack {
                Image(tabItem.imageName)
                    .frame(width: 24, height: 24)
            }
        }
    }
}


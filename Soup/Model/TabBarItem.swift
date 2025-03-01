//
//  TabBarItem.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//


import Foundation
import SwiftUI

struct TabBarItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
    let color: Color
    let width: CGFloat
}

enum Tabs: CaseIterable {
    case map
    case feelings
    case countdown
    case partner
    
    var item: TabBarItem {
        switch self {
        case .map:
            return TabBarItem(title: "Map", imageName: "Location", color: .blue, width: 110)
        case .feelings:
            return TabBarItem(title: "Feelings", imageName: "Feelings", color: .red, width: 108)
        case .countdown:
            return TabBarItem(title: "Countdown", imageName: "Countdown", color: .green, width: 130)
        case .partner:
            return TabBarItem(title: "Partner", imageName: "Partner", color: .purple, width: 102)
        }
    }
}

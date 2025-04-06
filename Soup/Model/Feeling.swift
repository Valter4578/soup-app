//
//  Feeling.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import Foundation
import SwiftUI

enum Feeling: String, CaseIterable {
    case happy
    case horny
    case sad
    case miss
    case calm
    case unamused
    case angry
    case worried
    
    var name: String {
        self.rawValue
    }
    
    var emojiText: String {
        switch self {
        case .happy:
            "🥰"
        case .horny:
            "😈"
        case .sad:
            "😔"
        case .miss:
            "😢"
        case .calm:
            "😌"
        case .unamused:
            "😒"
        case .angry:
            "😡"
        case .worried:
            "😵‍💫"
        }
    }
    
    var colorScheme: EmotionColorScheme {
        switch self {
        case .happy:
            EmotionColorScheme(primary: Color(hex: "FF7E57"),
                               primaryDimmed: Color(hex: "FF7E57").opacity(0.5),
                               light: Color(hex: "FFAD8D"),
                               gradient: LinearGradient(colors: [Color(hex: "FFAB3D"),
                                                                 Color(hex: "FF7E57"),
                                                                 Color(hex: "FFA45F")], startPoint: .top, endPoint: .bottom),
                               gradientDimmed: LinearGradient(colors: [Color(hex: "FFAB3D").opacity(0.8),
                                                                       Color(hex: "FF7E57").opacity(0.8),
                                                                       Color(hex: "FFA45F").opacity(0.8)], startPoint: .top, endPoint: .bottom),
                               background: LinearGradient(colors: [Color(hex: "FC756B"),
                                                                   Color(hex: "FF831D"),
                                                                   Color(hex: "FF4134")],
                                                          startPoint: .top,
                                                          endPoint: .bottom))
        case .sad:
            EmotionColorScheme(primary: Color(hex: "5AC8FA"),
                               primaryDimmed:  Color(hex: "5AC8FA").opacity(0.5),
                               light: Color(hex: "88D5FF"),
                               gradient: LinearGradient(colors: [Color(hex: "7AD0FF"), Color(hex: "49B6FF"), Color(hex: "81D3FF")], startPoint: .top, endPoint: .bottom),
                               gradientDimmed: LinearGradient(colors: [Color(hex: "7AD0FF").opacity(0.8), Color(hex: "49B6FF").opacity(0.8), Color(hex: "81D3FF").opacity(0.8)], startPoint: .top, endPoint: .bottom), background: LinearGradient(colors: [Color(hex: "7AD0FF"), Color(hex: "49B6FF"), Color(hex: "81D3FF")], startPoint: .top, endPoint: .bottom))
        case .miss:
            EmotionColorScheme(primary: Color(hex: "FFA4D4"),
                               primaryDimmed: Color(hex: "FFA4D4").opacity(0.5),
                               light: Color(hex: "FFBADF"),
                               gradient: LinearGradient(colors: [Color(hex: "FFB1DB"), Color(hex: "FF90CA"), Color(hex: "FFB5DD")], startPoint: .top, endPoint: .bottom),
                               gradientDimmed: LinearGradient(colors: [Color(hex: "FFB1DB").opacity(0.8), Color(hex: "FF90CA").opacity(0.8), Color(hex: "FFB5DD").opacity(0.8)], startPoint: .top, endPoint: .bottom), background: LinearGradient(colors: [Color(hex: "FFB1DB"), Color(hex: "FF90CA"), Color(hex: "FFB5DD")], startPoint: .top, endPoint: .bottom))
            
        default:
            EmotionColorScheme(primary: Color(hex: "FFA4D4"),
                               primaryDimmed: Color(hex: "FFA4D4").opacity(0.5),
                               light: Color(hex: "FFBADF"),
                               gradient: LinearGradient(colors: [Color(hex: "FFB1DB"), Color(hex: "FF90CA"), Color(hex: "FFB5DD")], startPoint: .top, endPoint: .bottom),
                               gradientDimmed: LinearGradient(colors: [Color(hex: "FFB1DB").opacity(0.8), Color(hex: "FF90CA").opacity(0.8), Color(hex: "FFB5DD").opacity(0.8)], startPoint: .top, endPoint: .bottom), background: LinearGradient(colors: [Color(hex: "FFB1DB"), Color(hex: "FF90CA"), Color(hex: "FFB5DD")], startPoint: .top, endPoint: .bottom))
        }
    }
}

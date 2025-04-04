//
//  Colors.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//
import SwiftUI

protocol ColorSchemeEnum {
    var primary: Color { get }
}

enum AppColors {
    enum Common {
        static let primary = Color("Lavander")
        static let secondary = Color("Pink")
        static let buttonColor = Color("ButtonColor").opacity(0.7)
    }
    
    enum Gradients {
        static var primaryGradient: LinearGradient {
            LinearGradient(
                colors: [Color(hex: "#D5A1FF"), Color(hex: "#A685FF"), Color(hex: "#B3A4FF")],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
    
    enum MeshGradientsColours {
        enum PurpleGradient {
            static let start = Color(hex: "#FE8FDA")
            static let middle = Color(hex: "#A685FF")
            static let end = Color(hex: "#B3A4FF")
        }
    }
    
    enum ColorSchemes {
        enum Miss {
            static let primary = Color(hex: "FFA4D4")
            static let primaryDimmed = Color(hex: "FFA4D4").opacity(0.5)
            static let light = Color(hex: "FFBADF")
            static let gradient = LinearGradient(colors: [Color(hex: "FFB1DB"), Color(hex: "FF90CA"), Color(hex: "FFB5DD")], startPoint: .top, endPoint: .bottom)
            static let gradientDimmed = LinearGradient(colors: [Color(hex: "FFB1DB").opacity(0.8), Color(hex: "FF90CA").opacity(0.8), Color(hex: "FFB5DD").opacity(0.8)], startPoint: .top, endPoint: .bottom)
        }
        
        enum Sad {
            static let primary = Color(hex: "5AC8FA")
            static let primaryDimmed = Color(hex: "5AC8FA").opacity(0.5)
            static let light = Color(hex: "88D5FF")
            static let gradient = LinearGradient(colors: [Color(hex: "7AD0FF"), Color(hex: "49B6FF"), Color(hex: "81D3FF")], startPoint: .top, endPoint: .bottom)
            static let gradientDimmed = LinearGradient(colors: [Color(hex: "7AD0FF").opacity(0.8), Color(hex: "49B6FF").opacity(0.8), Color(hex: "81D3FF").opacity(0.8)], startPoint: .top, endPoint: .bottom)
        }
        
        enum Happy {
            static let primary = Color(hex: "FF7E57")
            static let primaryDimmed = Color(hex: "FF7E57").opacity(0.5)
            static let light = Color(hex: "FFAD8D")
            static let gradient = LinearGradient(colors: [Color(hex: "FFAB3D"),
                                                          Color(hex: "FF7E57"),
                                                          Color(hex: "FFA45F")], startPoint: .top, endPoint: .bottom)
            static let gradientDimmed = LinearGradient(colors: [Color(hex: "FFAB3D").opacity(0.8),
                                                                Color(hex: "FF7E57").opacity(0.8),
                                                                Color(hex: "FFA45F").opacity(0.8)], startPoint: .top, endPoint: .bottom)

        }
    }
}


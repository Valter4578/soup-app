//
//  Colors.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//
import SwiftUI

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
}


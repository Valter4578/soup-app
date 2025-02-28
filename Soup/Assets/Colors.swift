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
}


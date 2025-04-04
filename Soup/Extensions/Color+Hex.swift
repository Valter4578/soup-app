//
//  Color+Hex.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI

extension Color {
    /// Returns the hex string representation of the Color (ignoring the alpha component).
    var hex: String? {
        // Convert SwiftUI Color to UIColor.
        let uiColor = UIColor(self)
        
        // Variables to hold the color components.
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Extract RGBA components.
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            // Convert components to integers (0...255).
            let r = Int(red * 255)
            let g = Int(green * 255)
            let b = Int(blue * 255)
            // Return formatted hex string.
            return String(format: "#%02X%02X%02X", r, g, b)
        }
        return nil
    }

    /// Inits Color with hex string 
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

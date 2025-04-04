//
//  AppFonts.swift
//  Soup
//
//  Created by Максим Алексеев  on 04.04.2025.
//

import Foundation
import SwiftUI

enum AppFonts {
    enum Bold {
        static var title1: Font {
            .system(size: 22, weight: .bold, design: .default)
        }
        
        static var title2: Font {
            .system(size: 20, weight: .bold, design: .default)
        }
        
        static var title3: Font {
            .system(size: 16, weight: .bold, design: .default)
        }
        
        static var large: Font {
            .system(size: 30, weight: .bold, design: .default)
        }
    }
    
    enum Semibold {
        static var title2: Font {
            .system(size: 16, weight: .semibold, design: .default)
        }
        
        static var title3: Font {
            .system(size: 14, weight: .semibold, design: .default)
        }
    }
    
    enum Regular {
        static var title1: Font {
            .system(size: 15, weight: .regular, design: .default)
        }
        
        static var title2: Font {
            .system(size: 12, weight: .regular, design: .default)
        }
    }
    
    enum BorsokFont {
        static var largeTitle: Font {
            .custom("Borsok", size: 80)
        }
        
        static var subtitle: Font {
            .custom("Borsok", size: 60)
        }
    }
}

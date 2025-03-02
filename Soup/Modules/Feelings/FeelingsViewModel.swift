//
//  FeelingsViewModel.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import Foundation

@Observable
class FeelingsViewModel {
    let partnersLastFeeling = Feeling(name: "Happy", emojiText: "😊", color: .orange)
    
    let feelings: [Feeling] = [
        Feeling(name: "Happy", emojiText: "😊", color: .yellow),
        Feeling(name: "Sad", emojiText: "😢", color: .blue),
        Feeling(name: "Angry", emojiText: "😡", color: .red),
        Feeling(name: "Surprised", emojiText: "😲", color: .green),
        Feeling(name: "Fearful", emojiText: "😱", color: .purple),
        Feeling(name: "Disgusted", emojiText: "🤢", color: .orange)
    ]
    
    func feelingText() -> String {
        let partnerName = "Emily" // TODO: - hardcoded for now fix later
        return "\(partnerName) feels \(partnersLastFeeling.name.lowercased()) today"
    }
}

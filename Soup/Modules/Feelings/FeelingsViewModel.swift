//
//  FeelingsViewModel.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import Foundation

@Observable
class FeelingsViewModel {
    // MARK: - Dependencies
    private var databaseService: DatabaseServiceProtocol?
    
    // MARK: - Properties
    var partnersLastFeeling = Feeling(name: "Happy", emojiText: "😊", color: .orange)
    
    let feelings: [Feeling] = [
        Feeling(name: "Happy", emojiText: "😊", color: .yellow),
        Feeling(name: "Sad", emojiText: "😢", color: .blue),
        Feeling(name: "Angry", emojiText: "😡", color: .red),
        Feeling(name: "Surprised", emojiText: "😲", color: .green),
        Feeling(name: "Fearful", emojiText: "😱", color: .purple),
        Feeling(name: "Disgusted", emojiText: "🤢", color: .orange)
    ]
    
    // MARK: - Inits
    init(databaseService: DatabaseServiceProtocol? = nil) {
        self.databaseService = databaseService
    }
    
    // MARK: - Functions
    
    func feelingText() -> String {
        let partnerName = "Emily" // TODO: - hardcoded for now fix later
        return "\(partnerName) feels \(partnersLastFeeling.name.lowercased()) today"
    }
    
    func sendFeeling(_ feeling: Feeling) {
        databaseService?.updateFeeling(feeling: feeling) { error in
            print(error)
        }
    }
    
    func listenPartnersFeeling() {
        databaseService?.getPartner { partnerId, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let partnerId = partnerId else { return }
            self.databaseService?.listenToPartnerFeeling(partnerId: partnerId) { feeling in
                guard let feeling = feeling else { return }
                self.partnersLastFeeling = feeling
            }
        }
    }
}

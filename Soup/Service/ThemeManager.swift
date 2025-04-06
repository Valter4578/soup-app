//
//  ThemeManager.swift
//  Soup
//
//  Created by Максим Алексеев  on 06.04.2025.
//

import Foundation
import Observation

@Observable
class ThemeManager {
    // MARK: - Dependencies
    private var databaseService: DatabaseServiceProtocol?
    
    // MARK: - Private
    private var currentFeeling: Feeling = .horny
    
    // MARK: - Public propertis
    var currentScheme: EmotionColorScheme {
        return currentFeeling.colorScheme
    }
    
    // MARK: - Init
    init(databaseService: DatabaseServiceProtocol) {
        self.databaseService = databaseService
    }
    
    // MARK: - Functions
    func updateFeeling(to feeling: Feeling) {
        currentFeeling = feeling
    }
    
    func listenToFeelingChanges() {
        databaseService?.getPartner { partnerId, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let partnerId = partnerId else { return }
            self.databaseService?.listenToPartnerFeeling(partnerId: partnerId) { feeling in
                guard let feeling = feeling else { return }
                self.currentFeeling = feeling
            }
        }
    }
}

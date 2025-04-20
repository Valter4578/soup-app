//
//  FeelingHistoryViewModel.swift
//  Soup
//
//  Created by Максим Алексеев  on 20.04.2025.
//

import Foundation
import Observation

@Observable
final class FeelingHistoryViewModel {
    // MARK: - Dependencies
    private let databaseService: DatabaseServiceProtocol?
    
    // MARK: - Properties
    var feelings: [FeelingResponse] = []
    
    // MARK: - Init
    init(databaseService: DatabaseServiceProtocol? = nil) {
        self.databaseService = databaseService
    }
    
    // MARK: - Functions
    func getFeelings() {
        databaseService?.getFeelings { feelings, error in
            if let error = error {
                print(error)
                return
            }
            
            self.feelings = feelings ?? []
        }
    }
}

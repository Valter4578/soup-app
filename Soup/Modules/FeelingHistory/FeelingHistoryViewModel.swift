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
        databaseService?.getPartnersFeelings { feelings, error in
            if let error = error {
                print(error)
                return
            }

            self.feelings = (feelings ?? []).sorted { $0.timestamp > $1.timestamp }
        }
    }

    /// Function that converts UNIX timestamp to date string
    func convertTimestampToDateString(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp) ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

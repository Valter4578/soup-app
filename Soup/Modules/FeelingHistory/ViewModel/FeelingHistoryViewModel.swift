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
    
    /// Groups feelings by date string (e.g. "Today", "Yesterday", or formatted date)
    var feelingsByDate: [(date: String, feelings: [FeelingResponse])] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date.now)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        var grouped: [String: [FeelingResponse]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        
        for feeling in feelings {
            let date = Date(timeIntervalSince1970: Double(feeling.timestamp / 1000))
            let startOfDay = calendar.startOfDay(for: date)
            let label: String
            if calendar.isDate(startOfDay, inSameDayAs: today) {
                label = "Today"
            } else if calendar.isDate(startOfDay, inSameDayAs: yesterday) {
                label = "Yesterday"
            } else {
                label = dateFormatter.string(from: startOfDay)
            }
            grouped[label, default: []].append(feeling)
        }
        
        // Sort sections by date descending
        let sorted = grouped.sorted { lhs, rhs in
            let lhsDate = lhs.value.first.map { Date(timeIntervalSince1970: Double($0.timestamp) ?? 0) } ?? Date.distantPast
            let rhsDate = rhs.value.first.map { Date(timeIntervalSince1970: Double($0.timestamp) ?? 0) } ?? Date.distantPast
            return lhsDate > rhsDate
        }
        return sorted.map { (date: $0.key, feelings: $0.value.sorted { $0.timestamp > $1.timestamp }) }
    }
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

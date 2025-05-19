//
//  CountdownViewModel.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import Combine
import Foundation
import SwiftUI

@Observable
final class CountdownViewModel {
    private let dbService: DatabaseServiceProtocol?

    init(dbService: DatabaseServiceProtocol?) {
        self.dbService = dbService
    }

    // MARK: - Properties

    enum State {
        case empty
        case running
    }

    var state: State = .empty

    private var timer: Timer?
    private var startDate: Date?
    var timeRemaining: TimeInterval = 0

    var formattedTime: String {
        let totalSeconds = Int(timeRemaining)

        let days = totalSeconds / (3600 * 24)
        let hours = (totalSeconds / 3600) % 24
        let minutes = (totalSeconds / 60) % 60
        let seconds = totalSeconds % 60

        if days > 0 {
            return String(format: "%02d day\n%02d:%02d:%02d", days, hours, minutes, seconds)
        } else {
            // Original calculation for hours when no days are shown
            let displayHours = totalSeconds / 3600
            return String(format: "%02d:%02d:%02d", displayHours, minutes, seconds)
        }
    }

    // MARK: - Public methods

    func startTimer(duration: TimeInterval = 3600) { // Default 1 hour
        state = .running
        timeRemaining = duration
        startDate = Date()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        }

        // dbService?.updateMeetingDate(Date(timeIntervalSince1970: 1_746_817_033.0))
    }

    func setCountdownt(to date: Date) {
        dbService?.updateMeetingDate(date)
        startTimer(duration: date.timeIntervalSinceNow)
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        state = .empty
    }

    func onAppear() {
        dbService?.listenToMeetingDateChanges { [weak self] date in
            self?.startTimer(duration: date?.timeIntervalSinceNow ?? 3600)
        }
    }

    // MARK: - Initialization

    deinit {}
}

//
//  CountdownViewModel.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import SwiftUI
import Foundation
import Combine

@Observable
final class CountdownViewModel {
    // MARK: - Properties
    enum State {
        case empty
        case running
    }
    
    var state: State = .empty
    
    private var timer: Timer?
    private var startDate: Date?
    var timeRemaining: TimeInterval = 0
    
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
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        state = .empty
    }
    
    var formattedTime: String {
        let hours = Int(timeRemaining) / 3600
        let minutes = Int(timeRemaining) / 60 % 60
        let seconds = Int(timeRemaining) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    // MARK: - Initialization
    deinit {
    }
}

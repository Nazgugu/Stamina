//
//  ChallengeItemViewModel.swift
//  Stamina
//
//  Created by Zhe Liu on 9/25/20.
//

import Foundation

struct ChallengeItemViewModel: Identifiable {
    
    var id: String {
        challenge.id!
    }
    
    private let challenge: Challenge
    
    var title: String {
        challenge.exercise.capitalized
    }
    
    var progressCircleViewModel: ProgressCircleViewModel {
        let dayNumber = daysFromStart + 1
        let message = isComplete ? "Done" : "\(dayNumber) of \(challenge.length)"
        return .init(title: "Day",
                     message: message,
                     percentageComplete: Double(dayNumber) / Double(challenge.length)
        )
    }
    
    private var daysFromStart: Int {
        let startDate = Calendar.current.startOfDay(for: challenge.startDate)
        let toDate = Calendar.current.startOfDay(for: Date())
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: startDate, to: toDate).day
            else {
                    return 0
            }
        return abs(daysFromStart)
    }
    
    private var isComplete: Bool {
        daysFromStart - challenge.length >= 0
    }
    
    var statusText: String {
        guard !isComplete else { return "Done" }
        let dayNumber = daysFromStart + 1
        return "Day \(dayNumber) of \(challenge.length)"
    }
    
    var dailyIncreaseText: String {
        "+\(challenge.increase) daily"
    }
    
    private let onDelete: (String) -> Void
    
    init(_ challenge: Challenge, onDelete: @escaping (String) -> Void) {
        self.challenge = challenge
        self.onDelete = onDelete
    }
    
    func tappedDelete() {
        if let id = challenge.id {
            onDelete(id)
        }
    }
}

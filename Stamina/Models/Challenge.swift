//
//  Challenge.swift
//  Stamina
//
//  Created by Zhe Liu on 9/22/20.
//

import Foundation
import FirebaseFirestoreSwift

struct Challenge: Codable {
    @DocumentID var id: String?
    
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
    let activities: [Activity]
}

struct Activity: Codable {
    let date: Date
    let isComplete: Bool
}

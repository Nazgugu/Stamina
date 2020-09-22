//
//  Challenge.swift
//  Stamina
//
//  Created by Zhe Liu on 9/22/20.
//

import Foundation

struct Challenge: Codable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
}

//
//  ProgressCircleViewModel.swift
//  Stamina
//
//  Created by Zhe Liu on 10/20/20.
//

import Foundation

struct ProgressCircleViewModel {
    let title: String
    let message: String
    let percentageComplete: Double
    var shouldShowTitle: Bool {
        percentageComplete <= 1
    }
}

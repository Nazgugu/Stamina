//
//  LandingViewModel.swift
//  Stamina
//
//  Created by Zhe Liu on 10/4/20.
//

import Foundation

final class LandingViewModel: ObservableObject {
    @Published var loginSignupPushed = false
    @Published var createPushed = false
    
    let title = "Stamina"
    let createButtonTitle = "Create a challenge"
    let createButtonImageName = "plus.circle"
    let alreadyButtonTitle = "I already have an account"
    let backgroundImageName = "pullups"
}

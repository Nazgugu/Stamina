//
//  SettingsViewModel.swift
//  Stamina
//
//  Created by Zhe Liu on 9/29/20.
//

import Foundation
import Combine
import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    //Just like an user defaults that it automatically sets the user defaults
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published private(set) var itemViewModels: [SettingsItemViewModel] = []
    let title: String =  "Settings"
    
    func item(at index: Int) -> SettingsItemViewModel {
        itemViewModels[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModels[index].type {
        case .mode:
            isDarkMode = !isDarkMode
            buildItems()
        default:
            break
        }
    }
    
    private func buildItems() {
        itemViewModels = [
            SettingsItemViewModel(title: "Create Account", iconName: "person.circle", type: .account),
            SettingsItemViewModel(title: "Switch to \(isDarkMode ? "Light" : "Dark") Mode", iconName: "lightbulb", type: .mode),
            SettingsItemViewModel(title: "Privacy Policy", iconName: "shield", type: .privacy)
        ]
    }
    
    func onAppear() {
        buildItems()
    }
    
}

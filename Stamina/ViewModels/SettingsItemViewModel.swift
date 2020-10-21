//
//  SettingsItemViewModel.swift
//  Stamina
//
//  Created by Zhe Liu on 9/29/20.
//

import Foundation

extension SettingsViewModel {
    struct SettingsItemViewModel {
        let title: String
        let iconName: String
        let type: SettingsItemType
    }

    enum SettingsItemType {
        case account
        case mode
        case privacy
        case logout
    }
}

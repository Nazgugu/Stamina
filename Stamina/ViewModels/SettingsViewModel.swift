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
    @Published var loginSignupPushed = false
    
    let title: String =  "Settings"
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func item(at index: Int) -> SettingsItemViewModel {
        itemViewModels[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModels[index].type {
        case .account:
            guard userService.currentUser?.email == nil else { return }
            loginSignupPushed = true
        case .mode:
            isDarkMode = !isDarkMode
            buildItems()
        case .logout:
            userService.logout().sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
        default:
            break
        }
    }
    
    private func buildItems() {
        itemViewModels = [
            SettingsItemViewModel(title: userService.currentUser?.email ?? "Create Account", iconName: "person.circle", type: .account),
            SettingsItemViewModel(title: "Switch to \(isDarkMode ? "Light" : "Dark") Mode", iconName: "lightbulb", type: .mode),
            SettingsItemViewModel(title: "Privacy Policy", iconName: "shield", type: .privacy)
        ]
        
        if userService.currentUser?.email != nil {
            itemViewModels += [.init(title: "Logout", iconName: "arrowshape.turn.up.left", type: .logout)]
        }
    }
    
    func onAppear() {
        buildItems()
    }
    
}

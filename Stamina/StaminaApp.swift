//
//  StaminaApp.swift
//  Stamina
//
//  Created by Zhe Liu on 9/21/20.
//

import SwiftUI
import Firebase

@main
struct StaminaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var appState = AppState()
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            if appState.isloggedIn {
                TabContainerView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            } else {
                LandingView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("setting up firebase")
        FirebaseApp.configure()
        return true
    }
}

class AppState: ObservableObject {
    @Published private(set) var isloggedIn = false
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
        
        userService
            .observeAuthChanges()
            .map { $0 != nil }
            .assign(to: &$isloggedIn)
    }
}

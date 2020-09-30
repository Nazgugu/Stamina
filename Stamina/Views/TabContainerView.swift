//
//  TabContainerView.swift
//  Stamina
//
//  Created by Zhe Liu on 9/24/20.
//

import SwiftUI

struct TabContainerView: View {
    @StateObject private var tabContainerViewModel = TabContainerViewModel()
    
    var body: some View {
        TabView(selection: $tabContainerViewModel.selectedtab) {
            ForEach(tabContainerViewModel.tabItemViewModels, id: \.self) { viewModel in
                tabView(for: viewModel.type)
                    .tabItem {
                        Image(systemName: viewModel.imageName)
                        Text(viewModel.title)
                    }.tag(viewModel.type) //need this to make the selection of tab work
            }
        }.accentColor(.primary)
    }
    
    @ViewBuilder
    func tabView(for tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType {
            case .log:
                Text("Log")
            case .challengeList:
                NavigationView {
                    ChallengeListView()
                }
            case .settings:
                NavigationView {
                    SettingsView()
                }
        }
    }
}

final class TabContainerViewModel: ObservableObject {
    
    @Published var selectedtab: TabItemViewModel.TabItemType = .challengeList
    
    let tabItemViewModels = [
        TabItemViewModel(imageName: "book", title: "Activity Log", type: .log),
        TabItemViewModel(imageName: "list.bullet", title: "Challenges", type: .challengeList),
        TabItemViewModel(imageName: "gear", title: "Settings", type: .settings)
    ]
}

struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case log
        case challengeList
        case settings
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
    }
}

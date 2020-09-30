//
//  SettingsView.swift
//  Stamina
//
//  Created by Zhe Liu on 9/29/20.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        List(viewModel.itemViewModels.indices, id: \.self) { index in
            Button {
                viewModel.tappedItem(at: index)
            } label: {
                HStack {
                    Image(systemName: viewModel.item(at: index).iconName)
                    Text(viewModel.item(at: index).title)
                }
            }
        }
        .navigationTitle(viewModel.title)
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

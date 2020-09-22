//
//  CreateView.swift
//  Stamina
//
//  Created by Zhe Liu on 9/21/20.
//

import SwiftUI

struct CreateView: View {
    
    @StateObject var viewModel = CreateChallengeViewModel()
    
    @State private var isActive: Bool = false
    
    var dropdownList: some View {
        ForEach(viewModel.dropdownds.indices, id: \.self) { index in
            DropdownView(viewModel: $viewModel.dropdownds[index])
        }
    }
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Select"),
                    buttons: viewModel.displayedOptions.indices.map { index in
                        let option = viewModel.displayedOptions[index]
                        return .default(Text(option.formattedValue)) {
                            //select option at index
                            viewModel.send(action: .selectOption(index: index))
                        }
                    })
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                NavigationLink(
                    destination: RemindView(),
                    isActive: $isActive
                    ) {
                    Button(action: {
                        isActive = true
                    }, label: {
                        Text("Next")
                            .font(.system(size: 24, weight: .medium))
                    })
                }
            }
            .actionSheet(isPresented: Binding<Bool>(get: {
                                                        viewModel.hasSelectedDropdown
                
            }, set: { _ in })) {
                actionSheet
            }
            .navigationBarTitle("Create")
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 15)
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}

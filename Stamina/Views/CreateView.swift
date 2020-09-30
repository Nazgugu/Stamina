//
//  CreateView.swift
//  Stamina
//
//  Created by Zhe Liu on 9/21/20.
//

import SwiftUI

struct CreateView: View {
    
    @StateObject var viewModel = CreateChallengeViewModel()
    
    var dropdownList: some View {
        Group {
            DropdownView(viewModel: $viewModel.exerciseDropdown)
            DropdownView(viewModel: $viewModel.startAmountDropdown)
            DropdownView(viewModel: $viewModel.increaseDropdown)
            DropdownView(viewModel: $viewModel.lengthDropdown)
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                Button(action: {
                    viewModel.send(action: .createChallenge)
                }, label: {
                    Text("Create")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.primary)
                })
            }
        }
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                mainContentView
            }
        }.alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil), content: { () -> Alert in
            Alert(title: Text("Error!"),
                  message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""),
                  dismissButton: .default(Text("OK"), action: {
                    viewModel.error = nil
                  }))
        })
        .navigationBarTitle("Create")
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, 15)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}

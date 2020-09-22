//
//  ContentView.swift
//  Stamina
//
//  Created by Zhe Liu on 9/21/20.
//

import SwiftUI

struct LandingView: View {
    
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.08)
                    Text("Stamina")
                        .font(.system(size: 64, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(
                        destination: CreateView(),
                        isActive: $isActive
                        ) {
                        Button(action: {
                            isActive = true
                        }, label: {
                            HStack(spacing: 15) {
                                Spacer()
                                Image(systemName: "plus.circle")
                                Text("Create a challenge")
                                Spacer()
                            }
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        })
                        .padding(15)
                        .buttonStyle(PrimaryButtonStyle())
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(
                    Image("pullups")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(Color.black.opacity(0.4))
                        .frame(width: proxy.size.width)
                        .edgesIgnoringSafeArea(.all)
                )
            }
        }.accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().previewDevice("iPhone 8")
        LandingView().previewDevice("iPhone 11 Pro")
        LandingView().previewDevice("iPhone 11 Pro Max")
    }
}

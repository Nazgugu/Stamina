//
//  RemindView.swift
//  Stamina
//
//  Created by Zhe Liu on 9/21/20.
//

import SwiftUI

struct RemindView: View {
    var body: some View {
        VStack {
            Spacer()
//            DropdownView()
            Spacer()
            Button(action: {}, label: {
                Text("Create")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }).padding(.bottom, 15)
            Button(action: {}, label: {
                Text("Skip")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            })
        }
        .navigationTitle("Remind")
        .padding(.bottom, 15)
    }
}

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RemindView()
        }
    }
}

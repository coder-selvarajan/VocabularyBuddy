//
//  PickMeaningHome.swift
//  Aangilam
//
//  Created by Selvarajan on 24/04/22.
//

import SwiftUI

struct PickMeaningHome: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Pick Meaning")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            Text("You will be given random words along with four choices to pick the correct one")
                .font(.body)
                .padding()
            
            Spacer()
            
            NavigationLink(
                destination: PickMeaning(),
                label: {
                    Text("START with saved words")
                        .font(.title3)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(.blue)
                        .cornerRadius(10)
                        .padding()
                })
            
            NavigationLink(
                destination: PickMeaning(),
                label: {
                Text("START with common words")
                    .font(.title3)
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(.indigo)
                    .cornerRadius(10)
                    .padding()
                })

            Spacer()
        }
    }
}

struct PickMeaningHome_Previews: PreviewProvider {
    static var previews: some View {
        PickMeaningHome()
    }
}

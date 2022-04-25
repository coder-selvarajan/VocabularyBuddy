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
            Text("Meaning Picker Game")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            Text("1. You will be given a word on screen \n\n2. You need to pick the correct meaning from four choices. \n\n3. and it repeats for five times")
                .font(.body)
                .padding(40)
            
            Spacer()
            
            NavigationLink(
                destination: PickMeaning(),
                label: {
                    HStack {
                        Image(systemName: "play.square")
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .padding(10)
                        VStack(alignment: .leading) {
                            Text("PLAY")
                                .font(.title)
                            Text("with my own words")
                                .font(.subheadline)
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame (width: 250, height: 90)
                    .background (Color.blue)
                    .cornerRadius(10)
                    .padding(10)
                    
//                    Text("PLAY with my words")
//                        .font(.title3)
//                        .padding()
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity, minHeight: 80)
//                        .background(.blue)
//                        .cornerRadius(10)
//                        .padding()
                })
            
            NavigationLink(
                destination: PickMeaning(),
                label: {
                    HStack {
                        Image(systemName: "play.square")
                            .resizable()
                            .aspectRatio(contentMode: ContentMode.fit)
                            .padding(10)
                        VStack(alignment: .leading) {
                            Text("PLAY")
                                .font(.title)
                            Text("with common words")
                                .font(.subheadline)
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame (width: 250, height: 90)
                    .background (Color.indigo)
                    .cornerRadius(10)
                    .padding(10)
//                Text("PLAY with common words")
//                    .font(.title3)
//                    .padding()
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity, minHeight: 80)
//                    .background(.indigo)
//                    .cornerRadius(10)
//                    .padding()
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

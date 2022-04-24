//
//  FlipCardGame.swift
//  Aangilam
//
//  Created by Selvarajan on 06/04/22.
//

import SwiftUI

struct FlipCardGame: View {
    @StateObject var userWordListVM = UserWordListViewModel()
    @State var word: String = "Enchanting"
    @State var meaning: String = "Feeling of extreme happiness"
    
    var body: some View {
        VStack {
            Spacer()
            
            FlipView {
                Text("\(word)")
            } back: {
                Text("\(meaning)")
            }

            Spacer()
            
            Button(action: {
                let wordObject = userWordListVM.pickRandomWord()
                word = wordObject.word ?? ""
                meaning = wordObject.meaning ?? ""
            }, label: {
                Text("Next Flip")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame (height: 55)
                    .frame (maxWidth: .infinity)
                    .background (Color.indigo)
                     .cornerRadius(10)
            })
            .padding()
            Spacer()

        }
        .navigationTitle("Word Flip Game")
        .onAppear(){
            userWordListVM.getAllUserWordEntries()
        }
//        .background(Color.pink.opacity(0.2)).ignoresSafeArea()
    }
}

//struct FlipCardGame_Previews: PreviewProvider {
//    static var previews: some View {
//        FlipCardGame()
//    }
//}

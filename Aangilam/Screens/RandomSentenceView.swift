//
//  RandomSentence.swift
//  Aangilam
//
//  Created by Selvarajan on 15/04/22.
//

import SwiftUI

struct RandomSentenceView: View {
    @StateObject var userSentenceListVM = UserSentenceListViewModel()
    @State var sentence: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            FlipView {
                Text("\(sentence)")
            } back: {
//                Text("\(meaning)")
            }

            Spacer()
            
            Button {
                let sentenceObject = userSentenceListVM.pickRandomSentence()
                sentence = sentenceObject.sentence
            } label: {
                Text("Pick next").font(.title2).foregroundColor(Color.white)
            }.padding().background(Color.cyan).cornerRadius(10)
            
            Spacer()

        }
        .navigationTitle("Random Pick")
        .onAppear(){
            userSentenceListVM.getAllUserSentenceEntries()
        }
    }
}

//struct RandomSentenceView_Previews: PreviewProvider {
//    static var previews: some View {
//        RandomSentence()
//    }
//}

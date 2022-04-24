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
            
            Button(action: {
                let sentenceObject = userSentenceListVM.pickRandomSentence()
                sentence = sentenceObject.sentence ?? ""
            }, label: {
                Text("Pick Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame (height: 55)
                    .frame (maxWidth: .infinity)
                    .background (Color.blue)
                    .cornerRadius(10)
            })
            .padding()
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

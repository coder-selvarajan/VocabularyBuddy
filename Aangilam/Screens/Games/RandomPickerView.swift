//
//  RandomPickerView.swift
//  Aangilam
//
//  Created by Selvarajan on 15/04/22.
//

import SwiftUI

struct RandomPickerView: View {
    @StateObject var userSentenceListVM = UserSentenceListViewModel()
    @StateObject var userWordListVM = UserWordListViewModel()
    @StateObject var userPhraseListVM = UserPhraseListViewModel()
    
    @State var sentence: String = ""
    @State private var type: Int = 1
    
    @State private var randomVocabulary: String = ""
    @State private var meaning: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Picker("", selection: $type) {
                Text("Word").tag(1)
                Text("Sentence").tag(2)
                Text("Phrase/Idiom").tag(3)
            }
            .pickerStyle(.segmented)
            .padding()
            .onChange(of: type, perform: { value in
                randomVocabulary = ""
                meaning = ""
            })
            
            FlipView {
                Text("\(randomVocabulary)")
                    .font(.title3)
            } back: {
                Text("\(meaning)")
                    .cornerRadius(10)
            }
            if (randomVocabulary != "") {
                Text("Flip the box to see the meaning, but before you do, Guess")
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
            }
            
            Spacer()
            
            Button(action: {
                if type == 1 { // "word"
                    let wordObject = userWordListVM.pickRandomWord()
                    randomVocabulary = wordObject.word ?? ""
                    meaning = wordObject.meaning ?? ""
                }
                if type == 2 { // "sentence"
                    let sentenceObject = userSentenceListVM.pickRandomSentence()
                    randomVocabulary = sentenceObject.sentence ?? ""
                }
                if type == 3 { // "phrase"
                    let phraseObject = userPhraseListVM.pickRandomPhrase()
                    randomVocabulary = phraseObject.phrase ?? ""
                    meaning = phraseObject.meaning ?? ""
                }
            }, label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fit)
                    Text(" Next")
                        .font(.title3)
                }
                .padding()
                .foregroundColor(.white)
                .frame (height: 55)
                .background (Color.blue)
                .cornerRadius(10)
            })
            .padding()
            Spacer()
        }
        .navigationTitle("Random Picker")
        .onAppear(){
            userWordListVM.getAllUserWordEntries()
            userSentenceListVM.getAllUserSentenceEntries()
            userPhraseListVM.getAllUserPhraseEntries()
        }
    }
}

//struct RandomPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        RandomPickerView()
//    }
//}

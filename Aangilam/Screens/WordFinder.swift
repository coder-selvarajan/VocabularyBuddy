//
//  WordFinder.swift
//  Aangilam
//
//  Created by Selvarajan on 23/04/22.
//

import SwiftUI

struct WordFinder: View {
    @StateObject var vmWordList = UserWordListViewModel()
    @State var randomWords = [UserWord]()
    
    func get30Characters(_ str: String) -> String {
        return String(str.prefix(30))
    }
    var body: some View {
        VStack {
            Spacer()

            if (randomWords.count > 0) {
                Text(randomWords[Int.random(in: 0...3)].word!)
                    .font(.title3)
                    .foregroundColor(.indigo)
                Divider()
                
                ForEach(randomWords, id:\.self) { word in
                    Text("- \(get30Characters(word.meaning ?? ""))")
                        .font(.headline)
                    
                }
            }

            Spacer()
            
            Button(action: {
                randomWords = vmWordList.pickRandomWords(4)
            }, label: {
                Text("Next Word")
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
        .navigationTitle("Word Finder")
        .onAppear(){
            vmWordList.getAllUserWordEntries()
            
        }
    }
}

//struct WordFinder_Previews: PreviewProvider {
//    static var previews: some View {
//        WordFinder()
//    }
//}

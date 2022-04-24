//
//  WordFinder.swift
//  Aangilam
//
//  Created by Selvarajan on 23/04/22.
//

import SwiftUI

struct PickMeaning: View {
    @StateObject var vmWordList = UserWordListViewModel()
    @State var randomWords = [UserWord]()
    @State private var answerSelection = 1
    @State private var chosenIndex : Int?
    @State private var showResult = false
    
    func get30Characters(_ str: String) -> String {
        return String(str.prefix(100))
    }
    func highlightColor(_ index: Int) -> Color {
        if let chosenIndex = chosenIndex {
            if (index == chosenIndex) {
                return Color.green
            }
        }
        
        return Color(hex: "f5f5f5")
    }
    var body: some View {
        VStack {
            Spacer()

            if (randomWords.count > 0) {
                Text(randomWords[Int.random(in: 0...3)].word!)
                    .font(.title)
                    .foregroundColor(.indigo)
                Divider()
                
                Spacer()
                
                ForEach(randomWords.indices, id:\.self) { index in
                    Button {
                        chosenIndex = index
                        showResult = true
                    } label: {
                        VStack(alignment: .leading) {
                            Text("\(randomWords[index].meaning ?? "")")
                                .lineLimit(2)
                                .font(.body)
                                .padding(10)
                                .foregroundColor(.black)
                                .multilineTextAlignment(TextAlignment.leading)
                                .frame(maxWidth: .infinity)
                        }
                        .background(highlightColor(index)) // Color(hex: "F5F5F5"))
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                    }
                }
            }

            Spacer()
            
            Button(action: {
                randomWords = vmWordList.pickRandomWords(4)
            }, label: {
                Text("NEXT")
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
        .navigationTitle("Choose the Meaning")
        .onAppear(){
            vmWordList.getAllUserWordEntries()
            
        }
    }
}

//struct PickMeaning_Previews: PreviewProvider {
//    static var previews: some View {
//        PickMeaning()
//    }
//}

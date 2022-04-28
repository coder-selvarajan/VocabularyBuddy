//
//  ViewUserWord.swift
//  Aangilam
//
//  Created by Selvarajan on 28/04/22.
//

import SwiftUI

struct ViewUserWord: View {
    @State var word: UserWord
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(word.word ?? "")")
                .font(.title)
                .foregroundColor(.indigo)
            
            Divider()
            Text("Meaning:")
                .font(.title2)
                .padding(.vertical, 10)
            Text("\(word.meaning ?? "")")
            
//            Divider()
            Text("Example usage:")
                .font(.title2)
                .padding(.top, 20)
                .padding(.bottom, 10)
            Text("\(word.sampleSentence ?? "")")
            
            Spacer()
        }
        .padding()
        .navigationTitle("View Word Info")
    }
}

//struct ViewUserWord_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewUserWord()
//    }
//}

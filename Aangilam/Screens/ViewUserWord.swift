//
//  ViewUserWord.swift
//  Aangilam
//
//  Created by Selvarajan on 28/04/22.
//

import SwiftUI

struct ViewUserWord: View {
    @State var word: UserWord
    @State var selection: Int? = nil
    
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
            
            NavigationLink(destination: EditUserWordView(userWord: $word),
                           tag: 1,
                           selection: $selection) {
                EmptyView()
            }
            
            Button {
                selection = 1
            } label: {
                Text("Edit Word")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame (height: 55)
                    .frame (maxWidth: .infinity)
                    .background (Color.indigo)
                    .cornerRadius(10)
            }
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

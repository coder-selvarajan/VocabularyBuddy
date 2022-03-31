//
//  AddUserWordView.swift
//  Aangilam
//
//  Created by Selvarajan on 14/03/22.
//

import SwiftUI

struct AddUserSentenceView: View {
    @StateObject var userSentenceListVM = UserSentenceListViewModel()
    @State private var sentence: String = ""
    @State private var tag: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Sentence: ")
                        TextEditor(text: $sentence)
                            .lineSpacing(20)
                            .frame(height: 100)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray).opacity(0.5))
                        
                    }.padding(.vertical, 5)
                    
                    VStack(alignment: .leading) {
                        Text("Tag: ")
                        TextEditor(text: $tag)
                            .lineSpacing(20)
                            .frame(height: 100)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray).opacity(0.5))
                        
                    }.padding(.vertical, 5)
                    
                    Button("Save Sentence") {
                        userSentenceListVM.saveSentence(sentence: sentence, tag: tag)
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.vertical)
                    .buttonStyle(.bordered)
                }
                
            }
            
        }
        
    }
}

struct AddUserSentenceView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserSentenceView()
    }
}

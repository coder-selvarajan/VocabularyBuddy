//
//  AddUserPhraseView.swift
//  Aangilam
//
//  Created by Selvarajan on 14/03/22.
//

import SwiftUI

struct AddUserPhraseView: View {
    @StateObject var userPhraseListVM = UserPhraseListViewModel()
    
    @State private var phrase: String = ""
    @State private var tag: String = ""
    @State private var example: String = ""
    @State private var meaning: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Phrase / Idiom", text: $phrase).font(.title2)
                    
                    VStack(alignment: .leading) {
                        Text("Meaning: ")
                        TextEditor(text: $meaning)
                            .lineSpacing(20)
                            .frame(height: 100)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray).opacity(0.5))
                        
                    }.padding(.vertical, 5)
                    
                    VStack(alignment: .leading) {
                        Text("Example: ")
                        TextEditor(text: $example)
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
                    
                    Button("Save Phrase/Idiom") {
                        userPhraseListVM.savePhrase(phrase: phrase,
                                                tag: tag,
                                                meaning: meaning,
                                                example: example )
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.vertical)
                    .buttonStyle(.bordered)
                }
                
            }
            
        }
        
    }
}

struct AddPhrase_Previews: PreviewProvider {
    static var previews: some View {
        AddUserPhraseView()
    }
}

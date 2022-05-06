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
    enum FocusField: Hashable {
        case field
    }
    
    @FocusState private var focusedField: FocusField?
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Phrase / Idiom", text: $phrase)
                        .font(.title2)
                        .focused($focusedField, equals: .field)
                    
                    VStack(alignment: .leading) {
                        Text("Meaning: ")
                        TextEditor(text: $meaning)
                            .frame(height: 140)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray).opacity(0.5))
                        
                    }.padding(.vertical, 5)
                    
                    VStack(alignment: .leading) {
                        Text("Example: ")
                        TextEditor(text: $example)
                            .frame(height: 120)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray).opacity(0.5))
                        
                    }.padding(.vertical, 5)
                    
                    VStack(alignment: .leading) {
                        Text("Tag: ")
                        TextEditor(text: $tag)
                            .frame(height: 100)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray).opacity(0.5))
                        
                    }.padding(.vertical, 5)
                    
                    Button(action: {
                        userPhraseListVM.savePhrase(phrase: phrase,
                                                tag: tag,
                                                meaning: meaning,
                                                example: example)
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save Phrase/Idiom")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame (height: 55)
                            .frame (maxWidth: .infinity)
                            .background (Color.cyan)
                            .cornerRadius(10)
                    })
                }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    /// Anything over 0.5 seems to work
                    self.focusedField = .field
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

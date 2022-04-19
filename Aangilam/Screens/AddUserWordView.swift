//
//  AddUserWordView.swift
//  Aangilam
//
//  Created by Selvarajan on 14/03/22.
//

import SwiftUI



struct AddUserWordView: View {
    @StateObject var userWordListVM = UserWordListViewModel()
    @State private var mode: String = "New"
    @State private var word: String = ""
    @State private var type: WORD_TYPE = WORD_TYPE.noun
    @State private var tag: String = ""
    @State private var sampleSentence: String = ""
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
                    TextField("Word \(mode)", text: $word)
                        .font(.title2)
                        .focused($focusedField, equals: .field)
                    
                    VStack(alignment: .leading) {
                        Text("Meaning: ")
                        TextEditor(text: $meaning)
                            .lineSpacing(20)
                            .frame(height: 100)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray).opacity(0.5))
                        
                    }.padding(.vertical, 5)
                    
                    VStack(alignment: .leading) {
                        Text("Sample Sentences: ")
                        TextEditor(text: $sampleSentence)
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
                    
                    Button(action: {
                        userWordListVM.saveWord(word: word,
                                                tag: tag,
                                                meaning: meaning,
                                                sampleSentence: sampleSentence)
                        
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save Word")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame (height: 55)
                            .frame (maxWidth: .infinity)
                            .background (Color.indigo)
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

struct AddWord_Previews: PreviewProvider {
    static var previews: some View {
        AddUserWordView()
    }
}

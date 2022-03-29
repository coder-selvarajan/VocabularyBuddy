//
//  AddUserWordView.swift
//  Mozhi
//
//  Created by Selvarajan on 14/03/22.
//

import SwiftUI

enum WORD_TYPE : String {
    case noun = "n", verb = "v", adjective = "adj", adverb = "adv", preposition = "pre";
}

struct AddUserWordView: View {
    @StateObject var userWordListVM = UserWordListViewModel()
    
    @State private var word: String = ""
    @State private var type: WORD_TYPE = WORD_TYPE.noun
    @State private var tag: String = ""
    @State private var sampleSentence: String = ""
    @State private var meaning: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            
            Form {
                Section {
                    TextField("Word", text: $word)
                    Picker("Type", selection: $type) {
                        Text("Noun").tag(WORD_TYPE.noun)
                        Text("Verb").tag(WORD_TYPE.verb)
                        Text("Adj").tag(WORD_TYPE.adjective)
                        Text("Adv").tag(WORD_TYPE.adverb)
                        Text("Prep").tag(WORD_TYPE.preposition)
                    }.pickerStyle(.segmented)
                        
                    VStack(alignment: .leading) {
                        Text("Tag: ")
                        TextEditor(text: $tag)
                            .lineSpacing(20)
                            .frame(height: 100)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray).opacity(0.5))
                        
                    }.padding(.vertical, 5)
                    
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
                    
                    Button("Save Word") {
                        userWordListVM.saveWord(word: word,
                                                tag: tag,
                                                meaning: meaning,
                                                sampleSentence: sampleSentence,
                                                type: type.rawValue )
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.vertical)
                    .buttonStyle(.borderedProminent)
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

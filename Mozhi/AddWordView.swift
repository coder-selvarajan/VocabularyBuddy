//
//  AddWord.swift
//  Mozhi
//
//  Created by Selvarajan on 14/03/22.
//

import SwiftUI

struct AddWordView: View {
    @StateObject var myWordListVM = MyWordListViewModel()
    
    @State private var word: String = ""
    @State private var tag: String = ""
    @State private var sampleSentence: String = ""
    @State private var meaning: String = ""
    
    var body: some View {
        
        VStack {
            
            Form {
                Section {
                    TextField("Word", text: $word)
                        
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
                        myWordListVM.saveWord(word: word, tag: tag, meaning: meaning, sampleSentence: sampleSentence)
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
        AddWordView()
    }
}

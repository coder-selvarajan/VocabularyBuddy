//
//  AddMyWordViewModel.swift
//  Mozhi
//
//  Created by Selvarajan on 14/03/22.
//

import Foundation


class AddMyWordViewModel: ObservableObject {
    var creationDate: Date = Date()
    var word: String = ""
    var tag: String = ""
    var sampleSentence: String = ""
    var meaning: String = ""
    
    func save() {
        let myWord = MyWord(context: MyWord.viewContext)
        myWord.creationDate = Date()
        myWord.word = word
        myWord.tag = tag
        myWord.sampleSentence = sampleSentence
        myWord.meaning = meaning
        
        myWord.save()
    }
    
}

//
//  AddUserWordViewModel.swift
//  Aangilam
//
//  Created by Selvarajan on 14/03/22.
//

import Foundation


class AddUserWordViewModel: ObservableObject {
    var creationDate: Date = Date()
    var word: String = ""
    var tag: String = ""
    var sampleSentence: String = ""
    var meaning: String = ""
    var type:String = ""
    
    func save() {
        let userWord = UserWord(context: UserWord.viewContext)
        userWord.creationDate = Date()
        userWord.word = word
        userWord.tag = tag
        userWord.sampleSentence = sampleSentence
        userWord.meaning = meaning
        userWord.type = type
        
        userWord.save()
    }
    
}

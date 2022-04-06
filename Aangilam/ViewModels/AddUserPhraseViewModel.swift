//
//  AddUserPhraseViewModel.swift
//  Aangilam
//
//  Created by Selvarajan on 14/03/22.
//

import Foundation

class AddUserPhraseViewModel: ObservableObject {
    var creationDate: Date = Date()
    var phrase: String = ""
    var tag: String = ""
    var example: String = ""
    var meaning: String = ""
    
    func save() {
        let userPhrase = UserPhrase(context: UserPhrase.viewContext)
        userPhrase.creationDate = Date()
        userPhrase.phrase = phrase
        userPhrase.tag = tag
        userPhrase.example = example
        userPhrase.meaning = meaning
        
        userPhrase.save()
    }
}

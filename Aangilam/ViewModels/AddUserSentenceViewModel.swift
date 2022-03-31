//
//  AddUserSentenceViewModel.swift
//  Aangilam
//
//  Created by Selvarajan on 31/03/22.
//

import Foundation


class AddUserSentenceViewModel: ObservableObject {
    var creationDate: Date = Date()
    var tag: String = ""
    var sentence: String = ""
    
    func save() {
        let userSentence = UserSentence(context: UserSentence.viewContext)
        userSentence.creationDate = Date()
        userSentence.tag = tag
        userSentence.sentence = sentence
        
        userSentence.save()
    }
    
}

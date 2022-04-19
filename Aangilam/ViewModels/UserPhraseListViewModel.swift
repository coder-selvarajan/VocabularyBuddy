//
//  UserPhraseListViewModel.swift
//  Aangilam
//
//  Created by Selvarajan on 13/03/22.
//

import Foundation
import CoreData

class UserPhraseListViewModel: ObservableObject {
    @Published var userPhraseAllEntries = [UserPhrase]()
    @Published var userPhraseRecentEntries = [UserPhrase]()
    
    func getAllUserPhraseEntries() {
        let userPhraseEntries : [UserPhrase] = UserPhrase.all()

        DispatchQueue.main.async {
            self.userPhraseAllEntries = userPhraseEntries //.map(UserPhraseViewModel.init)
        }
    }
    
    func getRecentPhraseEntries() {
        let PhraseEntries : [UserPhrase] = UserPhrase.getRecentFiveRecords()

        DispatchQueue.main.async {
            self.userPhraseRecentEntries = PhraseEntries //.map(UserPhraseViewModel.init)
        }
    }
    
    func savePhrase(phrase: String, tag: String, meaning: String, example: String){
        let userPhrase = UserPhrase(context: UserPhrase.viewContext)
        userPhrase.creationDate = Date()
        userPhrase.phrase = phrase
        userPhrase.tag = tag
        userPhrase.example = example
        userPhrase.meaning = meaning
        
        userPhrase.save()
    }
    
    func deletePhrase(phrase: UserPhrase) {
        let userPhrase: UserPhrase? = UserPhrase.byId(id: phrase.objectID)
        
        if let userPhrase = userPhrase {
            userPhrase.delete()
            getAllUserPhraseEntries()
            getRecentPhraseEntries()
        }
    }
}


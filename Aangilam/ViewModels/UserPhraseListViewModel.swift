//
//  UserPhraseListViewModel.swift
//  Aangilam
//
//  Created by Selvarajan on 13/03/22.
//

import Foundation
import CoreData

class UserPhraseListViewModel: ObservableObject {
    @Published var userPhraseAllEntries = [UserPhraseViewModel]()
    @Published var userPhraseRecentEntries = [UserPhraseViewModel]()
    
    func getAllUserPhraseEntries() {
        let userPhraseEntries : [UserPhrase] = UserPhrase.all()

        DispatchQueue.main.async {
            self.userPhraseAllEntries = userPhraseEntries.map(UserPhraseViewModel.init)
        }
    }
    
    func getRecentPhraseEntries() {
        let PhraseEntries : [UserPhrase] = UserPhrase.getRecentFiveRecords()

        DispatchQueue.main.async {
            self.userPhraseRecentEntries = PhraseEntries.map(UserPhraseViewModel.init)
        }
    }
    
    func savePhrase(phrase: String, tag: String, meaning: String, example: String){
        let newPhraseVM = AddUserPhraseViewModel()
        newPhraseVM.phrase = phrase
        newPhraseVM.tag = tag
        newPhraseVM.meaning = meaning
        newPhraseVM.example = example
        
        newPhraseVM.save()
    }
    
    func deletePhrase(phrase: UserPhraseViewModel) {
        let userPhrase: UserPhrase? = UserPhrase.byId(id: phrase.id)
        
        if let userPhrase = userPhrase {
            userPhrase.delete()
            getAllUserPhraseEntries()
            getRecentPhraseEntries()
        }
    }
}

struct UserPhraseViewModel: Identifiable {
    let userPhrase: UserPhrase
    
    var id: NSManagedObjectID {
        return userPhrase.objectID
    }
    
    var creationDate: Date {
        return userPhrase.creationDate ?? Date()
    }
    
    var phrase: String {
        return userPhrase.phrase ?? ""
    }
 
    var tag: String {
        return userPhrase.tag ?? ""
    }
    
    var example: String {
        return userPhrase.example ?? ""
    }
    
    var meaning: String {
        return userPhrase.meaning ?? ""
    }
    
}

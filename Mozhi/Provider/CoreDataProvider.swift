//
//  CoreDataProvider.swift
//  Mozhi
//
//  Created by Selvarajan on 13/03/22.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataProvider {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataProvider()
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "MozhiModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
        
//        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        print(directories[0])
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveWord(newword: String, tag: String, meaning: String, sampleSentences: String){
        let myWord = MyWord(context: viewContext)
        
        myWord.word = newword
        myWord.tag = tag
        myWord.meaning = meaning
        myWord.sampleSentence = sampleSentences
        myWord.creationDate = Date()
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save myWord entry")
        }
    }
    
    func deleteLoo(myWord: MyWord) {
        viewContext.delete(myWord)
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func getAllMyWords() -> [MyWord] {
        let fetchRequest : NSFetchRequest<MyWord> = MyWord.fetchRequest()
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func updateMyWord(myWord: MyWord){
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }
}

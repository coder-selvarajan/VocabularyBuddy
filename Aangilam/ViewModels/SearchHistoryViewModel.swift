//
//  SearchHistoryViewModel.swift
//  Aangilam
//
//  Created by Selvarajan on 10/05/22.
//

import Foundation
import CoreData

class SearchHistoryViewModel: ObservableObject {
    @Published var searchHistoryAllEntries = [SearchHistory]()
    @Published var searchHistoryRecentEntries = [SearchHistory]()
    
    func getAllSearchEntries() {
        let searchEntries : [SearchHistory] = SearchHistory.all()

        DispatchQueue.main.async {
            self.searchHistoryAllEntries = searchEntries
        }
    }
    
    func getRecentSearchEntries() {
        let searchEntries : [SearchHistory] = SearchHistory.getRecentRecords(limit: 15)

        DispatchQueue.main.async {
            self.searchHistoryRecentEntries = searchEntries
        }
    }
    
    func saveSearchEntry(word: String, definition: String){
        let searchEntry = SearchHistory(context: SearchHistory.viewContext)
        
        searchEntry.creationDate = Date()
        searchEntry.word = word
        searchEntry.definition = definition
        
        searchEntry.save()
    }
    
    func deleteSearchEntry(searchEntry: SearchHistory) {
        let searchHistoryItem: SearchHistory? = SearchHistory.byId(id: searchEntry.objectID)
        
        if let searchHistoryItem = searchHistoryItem {
            searchHistoryItem.delete()
            getAllSearchEntries()
            getRecentSearchEntries()
        }
    }
}

//
//  Dictionary.swift
//  Aangilam
//
//  Created by Selvarajan on 21/04/22.
//

import Foundation
import SwiftUI

class vmDictionary : ObservableObject {
    @Published var wordInfo: WordElement?
    @Published var isFetching: Bool = false
    @Published var definitionFound: Bool?
    
    func fetchData(inputWord: String, searchHistoryVM: SearchHistoryViewModel) {
        if inputWord != "" {
            let stringURL = "https://api.dictionaryapi.dev/api/v2/entries/en/\(inputWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))"
            guard let url = URL(string: stringURL) else {
                print("Invalid URL")
                self.isFetching = false
                return
            }
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    self?.isFetching = false
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(Words.self, from: data)
                    DispatchQueue.main.async {
                        self?.wordInfo = decodedData.first!
                        self?.isFetching = false
                        self?.definitionFound = true
                        
                        //saving the search entry in core data
                        searchHistoryVM.saveSearchEntry(word: inputWord)
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        self?.isFetching = false
                        self?.definitionFound = false
                    }
                    print(error)
                }
            }.resume()
            
        }
    }
    
}

enum PartOfSpeech: String, CaseIterable {
    case noun
    case verb
    case adjective
    case adverb
    case exclamation
    case conjunction
    case pronoun
    case number
    case unknown
}

struct Dictionary: View {
    @StateObject var userWordListVM = UserWordListViewModel()
    @StateObject var searchHistoryVM = SearchHistoryViewModel()
    @State var dictionaryJson: [String] = []
    @State var filteredItems: [String] = []
    @State private var searchText = "grace"
    @State var word: WordElement?
    @State private var descriptionField = ""
    @State private var partOfSpeech: PartOfSpeech = .unknown
    @State private var showingAlert = false
    @State private var searchStarted = false
    @StateObject var vmDict = vmDictionary()
    enum FocusField: Hashable {
        case search
    }
    @FocusState private var focusedField: FocusField?
    @Environment(\.presentationMode) var presentationMode
    
    func searchSubmit() {
        searchStarted = true
        vmDict.definitionFound = nil
        vmDict.isFetching = true
        vmDict.fetchData(inputWord: searchText, searchHistoryVM: searchHistoryVM)
    }
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            ScrollView {
                HStack {
                    TextField("Search...", text: $searchText)
                        .font(.title3)
                        .padding()
                        .background(.gray.opacity(0.1))
                        .cornerRadius(10)
                        .focused($focusedField, equals: .search)
                        .submitLabel(SubmitLabel.search)
                        .onSubmit {
                            searchSubmit()
                        }
                }.padding()
                
                if (!searchStarted) {
                    //Display previous search terms here
                    ForEach(searchHistoryVM.searchHistoryRecentEntries, id:\.objectID) { searchterm in
                        HStack {
                            Text(searchterm.word ?? "")
                                .font(.callout)
                                .onTapGesture {
                                    searchText = searchterm.word ?? ""
                                    searchSubmit()
                                }
                            Spacer()
                            Image(systemName: "xmark")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                                .onTapGesture {
                                    searchHistoryVM.deleteSearchEntry(searchEntry: searchterm)
                                }
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        
                        Divider().padding(.horizontal)
                    }
                }
                
                if (vmDict.isFetching) {
                    Text("Loading definition...")
                        .padding()
                        .foregroundColor(.gray)
                }
                
                if let defFound = vmDict.definitionFound {
                    if (!defFound) {
                        Text("No definition found for '**\(searchText)**'")
                            .padding()
                            .foregroundColor(.red)
                    }
                }
                
                if vmDict.wordInfo != nil {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(vmDict.wordInfo?.word.capitalized ?? "")
                            .font(.largeTitle)
                        
                        HStack(spacing: 15) {
                            Text("Phonetics:").font(.headline).foregroundColor(.blue)
                            Text("\(vmDict.wordInfo?.phonetic ?? "") ")
                            Image(systemName: "play.circle")
                        }.padding(.top, 0)
                        
                        Divider()
                        Text("Definition:").font(.headline).foregroundColor(.blue)
                        Text("\(extractMeaning(meanings: vmDict.wordInfo!.meanings))").padding(.top, 0)
                        Divider()
                        
                        if (extractExmple(meanings: vmDict.wordInfo!.meanings) != "") {
                            Text("Example Usage:").font(.headline).foregroundColor(.blue)
                            Text("\(extractExmple(meanings: vmDict.wordInfo!.meanings))").padding(.top, 0)
                        }
                        
                        Button(action: {
                            userWordListVM.saveWord(word: vmDict.wordInfo?.word ?? "",
                                                    tag: "from Dictionary",
                                                    meaning: extractMeaning(meanings: vmDict.wordInfo!.meanings),
                                                    sampleSentence: extractExmple(meanings: vmDict.wordInfo!.meanings))
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("+ Add this word to my list")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame (height: 55)
                                .frame (maxWidth: .infinity)
                                .background (Color.indigo)
                                .cornerRadius(10)
                        })
                    }.padding()
                }
            }
            .onAppear {
                searchHistoryVM.getRecentSearchEntries()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                    /// Anything over 0.5 seems to work
                    self.focusedField = .search
                }
            }
        }
    }
    
    func extractMeaning(meanings: [Meaning]) -> String {
        var result: String = ""
        
        for meaning in meanings {
            if (result != "") { //just adding line break for next partOfSpeech meaning
                result += "\n\n"
            }
            result += meaning.partOfSpeech + " -  "
            for definition in meaning.definitions {
                result += definition.definition + " "
            }
        }
        return result
    }
    
    func extractExmple(meanings: [Meaning]) -> String {
        var result: String = ""
        var sentences: String = ""
        
        for meaning in meanings {
            for definition in meaning.definitions {
                if let example = definition.example {
                    sentences += "  - " + example + " \n"
                }
            }
            if (sentences != "") {
                result += "(as " + meaning.partOfSpeech + "): \n" + sentences + "\n"
                sentences = ""
            }
        }
        return result
    }
}

struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}


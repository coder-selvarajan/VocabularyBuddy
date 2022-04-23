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
    
    func fetchData(inputWord: String) {
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
                    print(data)
                    let decodedData = try JSONDecoder().decode(Words.self, from: data)
                    DispatchQueue.main.async {
                        self?.wordInfo = decodedData.first!
                        self?.isFetching = false
                    }
                    
                } catch {
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
    @State var dictionaryJson: [String] = []
    @State var filteredItems: [String] = []
    @State private var searchText = ""
    @State var word: WordElement?
    @State private var descriptionField = ""
    @State private var partOfSpeech: PartOfSpeech = .unknown
    @State private var showingAlert = false
    @StateObject var vmDict = vmDictionary()
    enum FocusField: Hashable {
        case search
    }
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            ScrollView {
                HStack {
                    TextField("Search...", text: $searchText)
                        .font(.title3)
                        .padding(10)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(10)
                        .focused($focusedField, equals: .search)
                        .submitLabel(SubmitLabel.search)
                        .onSubmit {
                            vmDict.isFetching = true
                            vmDict.fetchData(inputWord: searchText)
                        }
                }
                .padding(15)
                
                if (vmDict.isFetching) {
                    Text("Loading definition...")
                        .padding()
                        .foregroundColor(.gray)
                }
                
                if vmDict.wordInfo != nil {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(vmDict.wordInfo?.word ?? "")
                            .font(.title)
                            .foregroundColor(.indigo)
                        
                        Text("**Phonetics :** \(vmDict.wordInfo?.phonetic ?? "") ")
                        
                        HStack(spacing: 10) {
                            Text("Pronunciation ")
                            Image(systemName: "play.circle")
                        }
                        
                        Divider()
                        Text("Meaning:").font(.title3)
                        Text("\(extractMeaning(meanings: vmDict.wordInfo!.meanings))")
                        Divider()
                        Text("Example Usage:").font(.title3)
                        Text("\(extractExmple(meanings: vmDict.wordInfo!.meanings))")
                    }.padding()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
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


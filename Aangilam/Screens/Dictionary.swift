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
    
    func fetchData(inputWord: String) {
        if inputWord != "" {
            let stringURL = "https://api.dictionaryapi.dev/api/v2/entries/en/\(inputWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))"
            guard let url = URL(string: stringURL) else {
                print("Invalid URL")
                return
            }
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
                    print(data)
                    let decodedData = try JSONDecoder().decode(Words.self, from: data)
                    DispatchQueue.main.async {
                        self?.wordInfo = decodedData.first!
                        print(self?.wordInfo?.meanings.description ?? "")
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
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $searchText)
                    .font(.title3)
                    .padding(10)
                    .background(.gray.opacity(0.1))
                Spacer()
                Button  {
                    vmDict.fetchData(inputWord: searchText)
                    
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: SwiftUI.ContentMode.fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.mint)
                }
            }
            .padding(20)
            
            Spacer()
            
            Section {
                if vmDict.wordInfo != nil {
                    WordCard(
                        wordMeanings: vmDict.wordInfo!.meanings, tapGesture: { descriptionStr, partOfSpeechStr in
                            descriptionField = descriptionStr
                            
                            switch partOfSpeechStr {
                            case "noun":
                                partOfSpeech = .noun
                            case "verb":
                                partOfSpeech = .verb
                            case "adjective":
                                partOfSpeech = .adjective
                            case "adverb":
                                partOfSpeech = .adverb
                            case "exclamation":
                                partOfSpeech = .exclamation
                            case "conjunction":
                                partOfSpeech = .conjunction
                            case "pronoun":
                                partOfSpeech = .pronoun
                            case "number":
                                partOfSpeech = .number
                            default:
                                partOfSpeech = .unknown
                            }
                        })
                }
            }
        }
    }
}

struct WordCard: View {
    @State private var wordClassSelection = 0
    @State private var partOfSpeech = ""
    var wordMeanings: [Meaning]
    var indices: Range<Array<Definition>.Index> {
        wordMeanings[wordClassSelection].definitions.indices
    }
    var definitions: [Definition] {
        wordMeanings[wordClassSelection].definitions
    }
    var tapGesture: (String, String) -> Void
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Picker(selection: $wordClassSelection) {
                ForEach(wordMeanings.indices, id: \.self) { index in
                    Text("\(wordMeanings[index].partOfSpeech)")
                }
            } label: {
                Text("selection")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            TabView() {
                ForEach(indices, id: \.self) { index in
                    ScrollView {
                        VStack(alignment: .leading) {
                            if !definitions[index].definition.isEmpty {
                                Divider()
                                Text("**Definition \(index + 1):** \(definitions[index].definition)")
                                    .onTapGesture {
                                        partOfSpeech = wordMeanings[wordClassSelection].partOfSpeech
                                        tapGesture(definitions[index].definition, partOfSpeech)
                                    }
                                
                            }
                            if definitions[index].example != nil {
                                Divider()
                                Text("**Example:** \(definitions[index].example!)")
                            }
                            if !definitions[index].synonyms.isEmpty {
                                Divider()
                                Text("**Synonyms:** \(definitions[index].synonyms.joined(separator: ", "))")
                            }
                            if !definitions[index].antonyms.isEmpty {
                                Divider()
                                Text("**Antonyms:** \(definitions[index].antonyms.joined(separator: ", "))")
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .tabViewStyle(.page)
        }
    }
}

struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}


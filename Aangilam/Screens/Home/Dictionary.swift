//
//  Dictionary.swift
//  Aangilam
//
//  Created by Selvarajan on 21/04/22.
//

import Foundation
import SwiftUI
import SwiftSoup

//struct displayModel : Codable {
//    let word: String
//    let definition: String
//    let example: String?
//    let type: String?
//    let tag: String?
//}


class vmDictionary : ObservableObject {
    @Published var wordInfo: WordElement?
    @Published var isFetching: Bool = false
    @Published var definitionFound: Bool?
    @Published var dataDump: String?
    
    @Published var wordsApiResponse: WordsApiResponse?
    
    func fetchData(inputWord: String, searchHistoryVM: SearchHistoryViewModel) {
        if inputWord != "" {
            // 2. google search
            // https://www.google.co.in/search?q=contemporary+meaning
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
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(Words.self, from: data)
                    DispatchQueue.main.async {
                        self?.wordInfo = decodedData.first!
                        self?.isFetching = false
                        self?.definitionFound = true
                        
                        //saving the search entry in core data
                        searchHistoryVM.saveSearchEntry(word: inputWord, definition: extractMeaning(meanings: decodedData.first!.meanings))
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
    
    func fetchFromWordsApi(inputWord: String) {
        let headers = [
            "X-RapidAPI-Host": "wordsapiv1.p.rapidapi.com",
            "X-RapidAPI-Key": "d2b600d481mshbdab0e8414fa85ep1847a5jsn554b275028b4"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://wordsapiv1.p.rapidapi.com/words/\(inputWord.lowercased().trim())")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request as URLRequest) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                return
            }
            if let _ = response as? HTTPURLResponse {
                do {
                    let decodedData = try JSONDecoder().decode(WordsApiResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.wordsApiResponse = decodedData
                        self?.isFetching = false
                        self?.definitionFound = true
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.isFetching = false
                        self?.definitionFound = false
                    }
                    print(error)
                }
            }
        }.resume()
    }
    
    func fetchFromGoogle(inputWord: String, searchHistoryVM: SearchHistoryViewModel) {
        if inputWord != "" {
            // 2. google search
            // https://www.google.co.in/search?q=contemporary+meaning
            let stringURL = "https://www.google.co.in/search?q=\(inputWord.lowercased().trim())+meaning"
            guard let url = URL(string: stringURL) else {
                print("Invalid URL")
                self.isFetching = false
                return
            }
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    
//                    do {
                        var htmlString = String(decoding: data, as: UTF8.self)
                        let doc = try! SwiftSoup.parse(htmlString) // init SwiftSoup object
//                        doc.select("meta").remove()                // css query to select, then remove
//                        try! htmlString = doc.outerHtml()
                        try! htmlString = doc.body()!.text()
                    
//                    }
//                    catch {
//                        //
//                    }
                    
//                    self?.dataDump = String(decoding: data, as: UTF8.self)
                    self?.dataDump = htmlString
                    self?.isFetching = false
                    self?.definitionFound = true
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

struct ClearButton: ViewModifier
{
    @Binding var text: String
    @FocusState var searchIsFocused: Bool
    public func body(content: Content) -> some View
    {
        ZStack(alignment: .trailing)
        {
            content

            if !text.isEmpty
            {
                Button(action:
                {
                    self.text = ""
                    self.searchIsFocused = true
                })
                {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                        .font(.headline)
                }
                .padding(.trailing, 3)
            }
        }
    }
}

struct Dictionary: View {
    @StateObject var userWordListVM = UserWordListViewModel()
    @StateObject var searchHistoryVM = SearchHistoryViewModel()
    @State var dictionaryJson: [String] = []
    @State var filteredItems: [String] = []
    @State private var searchText = ""
    @State var word: WordElement?
    @State private var descriptionField = ""
    @State private var partOfSpeech: PartOfSpeech = .unknown
    @State private var showingAlert = false
    @State private var searchStarted = false
    @StateObject var vmDict = vmDictionary()
    @FocusState private var searchIsFocused: Bool
    @State private var dictType = 1
    
    @State var displayDifinition: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    func searchSubmit2FreeApi() {
        searchStarted = true
        vmDict.definitionFound = nil
        vmDict.isFetching = true
        vmDict.fetchData(inputWord: searchText, searchHistoryVM: searchHistoryVM)
    }
    
    func searchSubmit2Google() {
        searchStarted = true
        vmDict.definitionFound = nil
        vmDict.isFetching = true
        vmDict.fetchFromGoogle(inputWord: searchText, searchHistoryVM: searchHistoryVM)
    }
    
    func searchSubmit2WordsApi() {
        searchStarted = true
        vmDict.definitionFound = nil
        vmDict.isFetching = true
        vmDict.fetchFromWordsApi(inputWord: searchText)
    }
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            ScrollView {
                HStack {
                    TextField("Search words in dictionary...", text: $searchText)
                        .modifier(ClearButton(text: $searchText, searchIsFocused: _searchIsFocused))
                        .font(.headline)
                        .autocapitalization(UITextAutocapitalizationType.none)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(10)
                        .focused($searchIsFocused)
                        .submitLabel(SubmitLabel.search)
                        .onSubmit {
                            dictType = 1
                            
                            vmDict.wordsApiResponse = nil
                            vmDict.dataDump = nil
                            
                            searchSubmit2FreeApi()
                        }
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .padding(.leading, 10)

                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                if (!searchStarted) {
                    //Display previous search terms here
                    ForEach(searchHistoryVM.searchHistoryRecentEntries, id:\.objectID) { searchterm in
                        HStack {
                            HStack{
                                Text(searchterm.word ?? "")
                                    .font(.callout)
                                
                                Text(searchterm.definition ?? "")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }.onTapGesture {
                                searchText = searchterm.word ?? ""
                                searchSubmit2FreeApi()
                                searchIsFocused = false
                            }
                            
                            Spacer()
                            Image(systemName: "xmark")
                                .foregroundColor(Color(UIColor.opaqueSeparator))
                                .font(.footnote)
                                .onTapGesture {
                                    searchHistoryVM.deleteSearchEntry(searchEntry: searchterm)
                                }
                        }
                        .padding(.horizontal, 15)
                        .padding(.horizontal)
                        
                        Divider().padding(.horizontal)
                    }
                    if (searchHistoryVM.searchHistoryRecentEntries.count > 0) {
                        Button {
                            // clearing off the history
                            searchHistoryVM.deleteAll()
                        } label: {
                            Text("Clear History")
                                .foregroundColor(.red.opacity(0.8))
                                .font(.footnote)
                        }.padding()
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
                
                if !vmDict.isFetching && vmDict.wordInfo != nil {
                    VStack(alignment: .leading, spacing: 15) {
//                        Divider()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Button {
                                    dictType = 1
                                } label: {
                                    VStack{
                                        Text("DictionaryApi")
                                        Rectangle().frame(height: 1)
                                            .foregroundColor(dictType == 1 ? .indigo : .clear)
                                    }
                                }
                                .padding(.trailing)
                                .foregroundColor(dictType == 1 ? .indigo : .secondary)
                                
                                Button {
                                    if (vmDict.wordsApiResponse == nil) {
                                        // Do WordsApi fetch
                                        searchSubmit2WordsApi()
                                    }
                                    
                                    dictType = 2
                                } label: {
                                    VStack{
                                        Text("WordsApi")
                                        Rectangle().frame(height: 1)
                                            .foregroundColor(dictType == 2 ? .indigo : .clear)
                                    }
                                }
                                .padding(.trailing)
                                .foregroundColor(dictType == 2 ? .indigo : .secondary)
                                
                                Button {
                                    if (vmDict.dataDump == nil) {
                                        // Do google search
                                        searchSubmit2Google()
                                    }
                                    
                                    dictType = 3
                                } label: {
                                    VStack{
                                        Text("Google")
                                        Rectangle().frame(height: 1)
                                            .foregroundColor(dictType == 3 ? .indigo : .clear)
                                    }
                                }
                                .padding(.trailing)
                                .foregroundColor(dictType == 3 ? .indigo : .secondary)
                                
                                Button {
                                    dictType = 4
                                    
                                    let dictionary = Lexicontext.sharedDictionary()
//                                    let definition = dictionary?.definition(for: searchText)
                                    displayDifinition =  dictionary?.definition(for: searchText) ?? ""
                                    
                                    
                                    print(displayDifinition)
                                    
                                } label: {
                                    VStack{
                                        Text("LexiContext")
                                        Rectangle().frame(height: 1)
                                            .foregroundColor(dictType == 4 ? .indigo : .clear)
                                    }
                                }
                                .padding(.trailing)
                                .foregroundColor(dictType == 4 ? .indigo : .secondary)
                            }
                            .foregroundColor(.primary)
                            .font(.subheadline)
                        }
                        
                        Divider()
                        
                        if dictType == 1 {
                                Text(vmDict.wordInfo?.word ?? "")
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
                        }
                        
                        if dictType == 2 {
                            Text(vmDict.wordsApiResponse?.word ?? "")
                                .font(.largeTitle)
                            
                            HStack(spacing: 15) {
                                Text("Phonetics:").font(.headline).foregroundColor(.blue)
                                if (vmDict.wordsApiResponse != nil) {
                                    Text("\(vmDict.wordsApiResponse?.pronunciation.all ?? "") ")
                                }
                            }.padding(.top, 0)
                            
                            Divider()
                            Text("Definition:").font(.headline).foregroundColor(.blue)
                            if (vmDict.wordsApiResponse != nil) {
                                Text("\(extractDefinitionFrom(wordsApiResults: vmDict.wordsApiResponse!.results))").padding(.top, 0)
                            }
                            Divider()
                            
                            if (extractExmple(meanings: vmDict.wordInfo!.meanings) != "") {
                                Text("Example Usage:").font(.headline).foregroundColor(.blue)
                                if (vmDict.wordsApiResponse != nil) {
                                    Text("\(extractExampleFrom(wordsApiResults: vmDict.wordsApiResponse!.results))").padding(.top, 0)
                                }
                            }
                            
                            Button(action: {
                                if (vmDict.wordsApiResponse != nil) {
                                    userWordListVM.saveWord(word: vmDict.wordsApiResponse!.word,
                                                            tag: "WordsApi",
                                                            meaning: extractDefinitionFrom(wordsApiResults: vmDict.wordsApiResponse!.results),
                                                            sampleSentence: extractExampleFrom(wordsApiResults: vmDict.wordsApiResponse!.results))
                                }
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
                            
                        }
                        
                        if dictType == 3 {
                            Text("Google result here")
                            Text(vmDict.dataDump ?? "")
                                .padding()
                        }

                        if dictType == 4 {
                            
                            Text(searchText)
                                .font(.largeTitle)
                            
//                            HStack(spacing: 15) {
//                                Text("Phonetics:").font(.headline).foregroundColor(.blue)
//                                if (vmDict.wordsApiResponse != nil) {
//                                    Text("\(vmDict.wordsApiResponse?.pronunciation.all ?? "") ")
//                                }
//                            }.padding(.top, 0)
                            
                            Divider()
                            Text("Definition:").font(.headline).foregroundColor(.blue)
                            Text("\(displayDifinition)").padding(.top, 0)
                            Divider()
                        }
                        
                    }.padding()
                }
            }
            .onAppear {
                searchHistoryVM.getRecentSearchEntries()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                    /// Anything over 0.5 seems to work
                    self.searchIsFocused = true
                }
            }
        }
    }
}

struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}


//
//  Test.swift
//  Aangilam
//
//  Created by Selvarajan on 01/04/22.
//

import SwiftUI

struct Test: View {
    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""
    
    var body: some View {
        List {
            ForEach(searchResults, id: \.self) { name in
                NavigationLink(destination: Text(name)) {
                    Text(name)
                }
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Contacts")
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}

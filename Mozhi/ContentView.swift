//
//  ContentView.swift
//  Mozhi
//
//  Created by Selvarajan on 13/03/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var myWordListVM = MyWordListViewModel()
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                List(myWordListVM.myWordAllEntries, id: \.id) { myword in
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(myword.word)").font(.subheadline).bold()
                        Text("\(myword.meaning)").font(.subheadline)
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddWord(), tag: 1, selection: $selection) {
                            Button(action: {
                                // Add new word
                                self.selection = 1
                            }, label: {
                                Text("+")
                                    .font(.system(.largeTitle))
                                    .frame(width: 77, height: 70)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 7)
                            })
                            .background(Color.blue)
                            .cornerRadius(38.5)
                            .padding()
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                        } .ignoresSafeArea()
                        
                    }
                }
            }
            .onAppear {
                myWordListVM.getAllMyWordEntries()
            }
            .navigationTitle("My Words")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

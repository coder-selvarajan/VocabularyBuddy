//
//  Helpers.swift
//  Aangilam
//
//  Created by Selvarajan on 05/04/22.
//

import Foundation

enum WORD_TYPE : String {
    case noun = "n", verb = "v", adjective = "adj", adverb = "adv", preposition = "pre";
}

extension Range where Element: Hashable {
    func random(without excluded:[Element]) -> Element {
        let valid = Set(self).subtracting(Set(excluded))
        let random = Int(arc4random_uniform(UInt32(valid.count)))
        return Array(valid)[random]
    }
}

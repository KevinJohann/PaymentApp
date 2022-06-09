//
//  String+Additions.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import Foundation

extension String {
    ///  Function *containsOnlyCharactersIn* validate if the extended string is only composed with matchCharacters String parameter.
    /// - Parameter matchCharacters: String parameter to compare with the extended string.
    /// - Returns: Return true if a string is made up of only "matchCharacters".
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
}

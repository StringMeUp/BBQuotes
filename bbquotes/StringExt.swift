//
//  StringExt.swift
//  bbquotes
//
//  Created by Samir Ramic on 19.11.25.
//

import Foundation

extension String {
    
     func removeSpaces() -> String {
          self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCaseAndSpaces() -> String {
        self.removeSpaces().lowercased()
    }
}

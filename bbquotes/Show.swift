//
//  Show.swift
//  bbquotes
//
//  Created by Samir Ramic on 19.11.25.
//

import Foundation

enum Show: String {
    case breakingBad = "Breaking Bad"
    case betterCallSaul = "Better Call Saul"
    case elCamino = "El Camino"
    
    var tabIndex: Int {
        switch self {
        case .breakingBad: return 1
        case .betterCallSaul: return 2
        case .elCamino: return 3
        }
    }
}

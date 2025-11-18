//
//  Quote.swift
//  bbquotes
//
//  Created by Samir Ramic on 13.11.25.
//

import Foundation

struct Episode: Codable {
    let episodeId: Int
    let production: String
    let episode: Int
    let title: String
    let image: URL
    let synopsis, writtenBy, directedBy, airDate: String
    let characters: [String]
}

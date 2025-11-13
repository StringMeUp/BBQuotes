//
//  BbCharacter.swift
//  bbquotes
//
//  Created by Samir Ramic on 13.11.25.
//
import Foundation

struct BbCharacter: Codable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let fullName: String
    let aliases: [String]
    let status: String
    let portrayedBy: String
    let death: Death?
}

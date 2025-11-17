//
//  ViewModel.swift
//  bbquotes
//
//  Created by Samir Ramic on 14.11.25.
//

import Foundation

@Observable
@MainActor
class ViewModel {

    enum FetchStatus {
        case notStatrted
        case loading
        case success
        case failure(error: Error)
    }
    
    private(set) var status: FetchStatus = .notStatrted
    private let fetcher = FetchService()
    
    var quote: Quote
    var character: BbCharacter
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(
            contentsOf: Bundle.main
                .url(forResource: "samplequote", withExtension: "json")!
        )
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        
        let characterData = try! Data(
            contentsOf: Bundle.main
                .url(forResource: "samplecharacter", withExtension: "json")!
        )
        character = try! decoder.decode(BbCharacter.self, from: characterData)
        
    }
    
    func getData(for show: String) async {
        self.status = .loading
        do {
            quote = try await fetcher.fetchQuotes(from: show)
            character = try await fetcher.fetchCharacter(quote.character)
            character.death = try await fetcher.fetchDeath(for: character.name)
            status = .success
        } catch {
            status = .failure(error: error)
        }
    }
}

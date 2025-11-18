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
    var episode: Episode
    var isEpisode: Bool = false
    
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
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        episode = try! decoder.decode(Episode.self, from: episodeData)
        
    }
    
    func getData(for show: String, isEpisode: Bool) async {
        self.status = .loading
        self.isEpisode = isEpisode
        
        do {
            if isEpisode {
                episode = try await fetcher.fetchRandomEpisode()
            } else {
                quote = try await fetcher.fetchQuotes(from: show)
                character = try await fetcher.fetchCharacter(quote.character)
                character.death = try await fetcher.fetchDeath(for: character.name)
            }
            status = .success
        } catch {
            status = .failure(error: error)
        }
    }
}

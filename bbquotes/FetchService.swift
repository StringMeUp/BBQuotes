//
//  QuotesViewModel.swift
//  bbquotes
//
//  Created by Samir Ramic on 14.11.25.
//

import Foundation

struct FetchService {
    
    enum FetchError: Error {
        case badResponse
    }
    
    let baseUrl = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    // quote https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Better+Call+Saul
    // characters https://breaking-bad-api-six.vercel.app/api/characters?name=Jimmy+McGill
    // deaths https://breaking-bad-api-six.vercel.app/api/deaths
  
    func fetchQuotes(from show: String) async throws -> Quote {
        // Fetch url
        let quoteUrl = baseUrl.appending(path: "quotes/random")
        let fetchUrl = quoteUrl.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else { throw FetchError.badResponse }
        // Decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        // Return Quote
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> BbCharacter {
        // Fetch url
        let characterUrl = baseUrl.appending(path: "characters")
        let fetchUrl = characterUrl.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else { throw FetchError.badResponse }
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let bbCharacters = try decoder.decode([BbCharacter].self, from: data)
        // Return character
        return bbCharacters[0]
    }
    
    
    func fetchDeatch(for character: String) async throws -> Death? {
        // Fetch url
        let deathUrl = baseUrl.appending(path: "deaths")
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: deathUrl)
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200
        else { throw FetchError.badResponse }
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let deaths = try decoder.decode([Death].self, from: data)
        
        // Find
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        
        return nil
    }
}

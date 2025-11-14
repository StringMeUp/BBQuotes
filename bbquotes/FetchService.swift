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
    //https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Better+Call+Saul
  
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
}

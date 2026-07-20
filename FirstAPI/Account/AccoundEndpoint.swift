//
//  AccoundEndpoint.swift
//  FirstAPI
//
//  Created by Servan on 01.07.26.
//

import Foundation

enum AccoundEndpoint: Endpoint {
    case addToWatchlist(encodable: Encodable)
    case getWatchlistMovies(page: Int)
    
    var accountPath: String {
        "/account/\(23254416)"
    }
    var path: String {
        switch self {
        case .addToWatchlist:
            return "\(accountPath)/watchlist"
        case .getWatchlistMovies:
            return "\(accountPath)/watchlist/movies"
        }
    }
    var method: HttpMethod {
        switch self {
        case .addToWatchlist:
            .post
        case .getWatchlistMovies:
                .get
        }
    }
    var query: [URLQueryItem] {
        switch self {
        case .addToWatchlist:
            return []
        case .getWatchlistMovies(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        }
    }
    var requestBody: RequestBody? {
        switch self {
        case .addToWatchlist(let encodable):
            return .encodable(encodable)
        case .getWatchlistMovies:
            return nil
        }
    }
}

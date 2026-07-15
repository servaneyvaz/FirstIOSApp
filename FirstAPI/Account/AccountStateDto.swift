//
//  AccountStateDto.swift
//  FirstAPI
//
//  Created by Servan on 10.07.26.
//
import Foundation

// MARK: - AccountStateDto
struct AccountStateDto: Decodable {
    let id: Int?
    let favorite: Bool?
    let rated: Rated?
    let watchlist: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case favorite = "favorite"
        case rated = "rated"
        case watchlist = "watchlist"
    }
    
    var isWatchlist: Bool {
        guard let watchlist else { return false }
        return watchlist
    }
    
    
}
struct Rated: Decodable {
    let value: Int?

    enum CodingKeys: String, CodingKey {
        case value = "value"
    }
}

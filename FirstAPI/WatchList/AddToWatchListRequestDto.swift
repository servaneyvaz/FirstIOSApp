//
//  AddToWatchListRe.swift
//  FirstAPI
//
//  Created by Servan on 01.07.26.
//

import Foundation

// MARK: - AddToWatchListRequestDto
struct AddToWatchListRequestDto: Encodable {
    let mediaType: String
    let mediaId: Int
    let watchlist: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case watchlist = "watchlist"
    }
}

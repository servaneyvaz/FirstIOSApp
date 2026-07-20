//
//  MovieEndpoint.swift
//  FirstAPI
//
//  Created by Servan on 26.06.26.
//

import Foundation

enum MovieEndpoint: Endpoint {
    case getNowPlaying(page: Int)
    case upcoming(page: Int)
    case topRated(page: Int)
    case popularMovies(page: Int)
    case trendMovies(page: Int)
    case personDetails(id: Int)
    var path: String {
        var path = "/movie"
        switch self {
        case .getNowPlaying:
            path += "/now_playing"
        case .upcoming:
            path += "/upcoming"
        case .topRated:
            path += "/top_rated"
        case .popularMovies:
            path += "/popular"
        case .trendMovies:
            path = "/trending/movie/week"
        case .personDetails:
            path = "/person"
        }
        return path
    }
    var method: HttpMethod {
        switch self {
            case .getNowPlaying:
            return .get
        case .upcoming:
               return .get
        case .topRated:
            return .get
        case .popularMovies:
            return .get
        case .trendMovies:
            return .get
        case .personDetails:
            return .get
        }
    }
    var query: [URLQueryItem] {
        switch self {
            case .getNowPlaying(let page):
            return [.init(name: "page", value: "\(page)")]
        case .upcoming(let page):
            return [.init(name: "page", value: "\(page)")]
        case .topRated(let page):
            return [.init(name: "page", value: "\(page)")]
        case .popularMovies(let page):
            return [.init(name: "page", value: "\(page)")]
        case .trendMovies(page: let page):
            return [.init(name: "page", value: "\(page)")]
        case .personDetails:
            return []
        }
        
    }
    var requestBody: RequestBody? {
        switch self {
        case .getNowPlaying:
            return nil
        case .upcoming:
            return nil
        case .topRated:
            return nil
        case .popularMovies:
            return nil
        case .trendMovies:
            return nil
        case .personDetails:
            return nil
        }
    }
}

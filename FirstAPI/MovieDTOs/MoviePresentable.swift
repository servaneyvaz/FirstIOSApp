//
//  MoviePresentable.swift
//  FirstAPI
//
//  Created by Servan on 17.07.26.
//

import Foundation

protocol MoviePresentable {
    var id: Int? { get }
    var posterPathUrl: String? { get }
    var backdropPathURL: String? { get }
    var posterTitle: String? { get }
    var ratingAverage: Double? { get }
    var aboutmovie: String? { get }
    var releaseDate: String? { get }
    var watchlist: Bool? { get }
    var profilePathURL: String? { get }
    var namePath: String? { get }
    var contentOfMovie: String? { get }
}
extension MovieDto: MoviePresentable {
    
}
extension UpcomingList: MoviePresentable {
    var posterPathUrl: String?
    {
        return self.posterPathURL
    }
}
extension TrendMovieList: MoviePresentable {
    
}
extension TopRatedList: MoviePresentable {
    var posterPathUrl: String? {
        return self.posterpathUrl
    }
}
extension PopularMovieList: MoviePresentable {
    
}
extension MoviePresentable {
    var id: Int? { return nil }
    var posterPathUrl: String? { return "" }
    var backdropPathURL: String? { return "" }
    var posterTitle: String? { return "" }
    var ratingAverage: Double? { return nil }
    var aboutmovie: String? { return nil }
    var watchlist: Bool? { return nil }
    var releaseDate: String? { return nil }
    var profilePathURL: String? { return nil }
    var namePath: String? { return nil }
    var contentOfMovie: String? { return nil }
}

extension AccountStateDto: MoviePresentable {
    
}
extension CastMovieDto: MoviePresentable {
    var profilePathURL: String? {
        return self.profilePathUrl
    }
    var namePath: String? {
        return self.namePathCast
    }
}

extension ReviewListView: MoviePresentable {
    
}

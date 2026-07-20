//
//  TopRatedDto.swift
//  FirstAPI
//
//  Created by Servan on 27.06.26.
//


import Foundation

// MARK: - TopRatedDto
struct TopRatedDto: Decodable {
    let page: Int?
    let results: [TopRatedList]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TopRatedList: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    var posterpathUrl: String? {
        guard let posterPath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
    var backdropPathURL: String? {
        guard let backdropPath else { return nil }
        return "https://image.tmdb.org/t/p/w500\(backdropPath)"
    }
    var posterTitle: String? {
        guard let title else { return nil }
        return "\(title)"
    }
    var ratingAverage: Double? {
        guard let voteAverage else { return nil }
        return voteAverage
    }
    var aboutmovie: String? {
        guard let overview else { return nil }
        return overview
    }
}

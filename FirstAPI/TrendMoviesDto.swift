// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let trendMoviesDto = try? JSONDecoder().decode(TrendMoviesDto.self, from: jsonData)

import Foundation

// MARK: - TrendMoviesDto
struct TrendMoviesDto: Decodable {
    let page: Int?
    let results: [TrendMovieList]?
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
struct TrendMovieList: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let title: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let mediaType: String?
    let genreIds: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case id = "id"
        case title = "title"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case popularity = "popularity"
        case releaseDate = "release_date"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    var posterPathUrl: String? {
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

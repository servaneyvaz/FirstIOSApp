// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let castDto = try? JSONDecoder().decode(CastDto.self, from: jsonData)

import Foundation

// MARK: - CastDto
struct CastDto: Decodable {
    let id: Int?
    let cast: [CastMovieDto]?
    let crew: [CastMovieDto]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
        case crew = "crew"
    }
}

// MARK: - Cast
struct CastMovieDto: Decodable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castId: Int?
    let character: String?
    let creditId: String?
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case gender = "gender"
        case id = "id"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case originalName = "original_name"
        case popularity = "popularity"
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character = "character"
        case creditId = "credit_id"
        case order = "order"
        case department = "department"
        case job = "job"
    }
    
    var profilePathUrl : String {
        guard let profilePath else { return "" }
            return "https://image.tmdb.org/t/p/w500\(profilePath)"
    }
    var namePath : String {
        guard let name else { return "" }
        return name
        
    }
}


//
//  ReviewDto.swift
//  FirstAPI
//
//  Created by Servan on 23.07.26.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reviewDto = try? JSONDecoder().decode(ReviewDto.self, from: jsonData)

import Foundation

// MARK: - ReviewDto
struct ReviewDto: Decodable {
    let id: Int?
    let page: Int?
    let results: [ReviewListView]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ReviewListView: Decodable {
    let author: String?
    let authorDetails: AuthorDetails?
    let content: String?
    let createdAt: String?
    let id: String?
    let updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case authorDetails = "author_details"
        case content = "content"
        case createdAt = "created_at"
        case id = "id"
        case updatedAt = "updated_at"
        case url = "url"
    }
    
    var contentOfMovie: String? {
        guard let content = content else { return nil }
        return content.replacingOccurrences(of: "<br>", with: "\n")
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name: String?
    let username: String?
    let avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case username = "username"
        case avatarPath = "avatar_path"
        case rating = "rating"
    }
}

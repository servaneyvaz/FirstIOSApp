//
//  Endpoint.swift
//  FirstAPI
//
//  Created by Servan on 10.06.26.
//
import Foundation
protocol Endpoint {
    var path: String { get }
    var method: HttpMethod { get }
    var query: [URLQueryItem] { get }
    var requestBody:RequestBody? { get }
}
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
enum RequestBody {
    case rawData(Data)
    case encodable(Encodable)
    case dictionary([String: Encodable])
}

struct ErrorModel: Decodable,Error {
    private(set)var statusCode: Int?
    let statusMessage: String?
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
   mutating func set(statusCode: Int) {
        if self.statusCode == nil {
            self.statusCode = statusCode
        }
    }
   var localizedDescription: String {
       if let statusMessage = statusMessage {
           return statusMessage
       } else if let statusCode = statusCode {
           return "ERROR\(statusCode)"
       }
       return "Unknown Error"
    }
}

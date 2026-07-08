//
//  ApiModel.swift
//  FirstAPI
//
//  Created by Servan on 09.06.26.
//

import Foundation

final class NetworkManager {
    let session: URLSession
    let mainPath: String
    let header: [String: String]
    static let shared = NetworkManager(
        session: URLSession.shared,
        mainPath: "https://api.themoviedb.org/3",
        header: [
            "accept" : "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMzc3ZWM2YzZjMzlmZmZhMWMyYjIwZDIyYmMxZmZmMCIsIm5iZiI6MTc4MDc0MjAwMi4xMzIsInN1YiI6IjZhMjNmNzcyZWJhM2QxZjM1MDM4NTU4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eMnHYmQmR0erl2mVk57htgnGH_U7dR1nQXVMb8zSWxw"
        ]
    )
    private init(session: URLSession, mainPath: String,header: [String: String]) {
        self.session = session
        self.mainPath = mainPath
        self.header = header
    }
    func request<T: Decodable>(endpoint: Endpoint,completion: @escaping (Result<T, Error>) -> Void) {
        let request = urlrequest(endpoint: endpoint)
        let callback: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        switch request {
        case .success(let request):
            session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    callback(.failure(error))
                    return
                }
                guard let data else {
                    callback(.failure(LocalError.noData))
                    return
                }
                if let result = try? JSONDecoder().decode(T.self, from: data) {
                    callback(.success(result))
                } else {
                    
                    do{
                        let model = try JSONDecoder().decode(ErrorModel.self, from: data)
                        callback(.failure(model.self))
                    } catch {
                        callback(.failure(LocalError.decodingError))
                        }
                    }
            }.resume()
        case .failure(let error):
            callback(.failure(error))
        }
    }
    func urlrequest(endpoint: Endpoint) -> Result<URLRequest, Error>{
        let path = "\(mainPath)/\(endpoint.path)"
        guard var url = URL(string: path) else {
            return .failure(LocalError.invalidUrl)
        }
        url.append(queryItems: endpoint.query)
        var request = URLRequest(url: url)
        header.forEach({
            request.setValue($1,forHTTPHeaderField: $0)
        })
        request.httpMethod = endpoint.method.rawValue
        if let body = endpoint.requestBody {
            switch body {
            case .rawData(let data):
                request.httpBody = data
            case .encodable(let encodable):
                do {
                    let data = try JSONEncoder().encode(encodable)
                    request.httpBody = data
                } catch {
                return .failure(error)
                }
            case .dictionary(let dictionary):
                do { let data = try JSONSerialization.data(withJSONObject: dictionary)
                    request.httpBody = data
                }
                catch {
                        return .failure(error)
                    }
            }
        }
        return .success(request)
    }
    func loadData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let callback: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        guard let url = URL(string: urlString) else {
            callback(.failure(LocalError.invalidUrl))
            return
        }
        session.dataTask(with: url, completionHandler: { data , urlResponse , error in
            if let error = error {
                callback(.failure(error))
                return
            }
            guard let data else {
                callback(.failure(LocalError.noData))
                return
            }
            callback(.success(data))
            
        }).resume()
    }
}

enum LocalError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case decodingError
    case noData
    
    var localizedDescription: String {
        switch self {
            
        case .invalidUrl:
            "invalidUrl"
        case .invalidResponse:
            "invalidResponse"
        case .invalidData:
            "invalidData"
        case .decodingError:
            "decodingError"
        case .noData:
            "noData"
        }
    }
}

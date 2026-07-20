//
//  AccountApiService.swift
//  FirstAPI
//
//  Created by Servan on 01.07.26.
//

final class AccountApiService {
    static let shared = AccountApiService()
    func addToWatchlist(requestModel: AddToWatchListRequestDto, completion: @escaping (Result<ErrorModel, Error>) -> Void) {
        NetworkManager.shared.request(
            endpoint: AccoundEndpoint.addToWatchlist(encodable: requestModel),
            completion: completion)
    }
    func getToWatchList<T: Decodable>(page: Int, completion: @escaping (Result<T, Error>) -> Void) {
        NetworkManager.shared.request(endpoint: AccoundEndpoint.getWatchlistMovies(page: page), completion: completion)
    }
}

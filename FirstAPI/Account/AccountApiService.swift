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
    
    func getMovieAccountStates(id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        // TMDB-də bu endpoint: /movie/{movie_id}/account_states şəklindədir
        let urlString = "https://api.themoviedb.org/3/movie/\(id)/account_states"
        
        // Öz network menecerinlə bu URL-ə GET sorğusu atırsan.
        // Gələn JSON-da birbaşa "watchlist": true/false dəyəri olur.
        // Uğurlu cavab gələndə completion(.success(model.watchlist)) ötürürsən.
    }
}

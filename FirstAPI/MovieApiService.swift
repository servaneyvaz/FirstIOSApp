//
//  MovieApiService.swift
//  FirstAPI
//
//  Created by Servan on 26.06.26.
//
import Foundation

final class MovieApiService {
    static let shared = MovieApiService()
    private init(){
        
    }
    func getNowPlaying(page: Int, completion: @escaping (Result<NowPlayingDto, Error>) -> Void) {
        NetworkManager.shared.request(endpoint: MovieEndpoint.getNowPlaying(page: page), completion: completion)
    }
    func getUpcoming(page: Int, completion: @escaping (Result<UpcomingDto, Error>) -> Void) {
        NetworkManager.shared.request(endpoint: MovieEndpoint.upcoming(page: page), completion: completion)
    }
    func getTopRated(page: Int, completion: @escaping (Result<TopRatedDto,Error>) -> Void ) {
        NetworkManager.shared.request(endpoint: MovieEndpoint.topRated(page: page), completion: completion)
    }
    func getPopular(page: Int, completion: @escaping (Result<PopularMoviesDto,Error>) -> Void ) {
        NetworkManager.shared.request(endpoint: MovieEndpoint.popularMovies(page: page), completion: completion)
    }
    func getTrending(page: Int, completion: @escaping (Result<TrendMoviesDto,Error>) -> Void ) {
        NetworkManager.shared.request(endpoint: MovieEndpoint.trendMovies(page: page), completion: completion)
    }
    func getPersonDetails(id: Int, completion: @escaping (Result<TrendMoviesDto,Error>) -> Void ) {
        NetworkManager.shared.request(endpoint: MovieEndpoint.personDetails(id: id), completion: completion)
    }
}

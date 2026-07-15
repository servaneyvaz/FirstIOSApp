//
//  Untitled.swift
//  FirstAPI
//
//  Created by Servan on 01.07.26.
//

import Foundation
final class NowPlayingListViewModel: MovieListViewModel {
    var isWatchlist: [AccountStateDto] = []
    
    var upcomingMovies: [UpcomingList] = []
    
    var topRatedMovies: [TopRatedList] = []
    
    var popularMovies: [PopularMovieList] = []
    
    var trendMovies: [TrendMovieList] = []
    
    var callback: ((MovieListViewState) -> Void)?
    
    private(set) var movies: [MovieDto] = []
    
    func getMovies() {
        nowPlayingConfigure()
    }
   
    private func nowPlayingConfigure() {
        callback?(.loading)
        MovieApiService.shared.getNowPlaying(page: 1, completion: {
            [weak self] result in
            guard let self else { return }
            callback?(.loaded)
            
                switch result {
                case .success(let movies):
                    self.movies = movies.results ?? []
                    callback?(.reload)
                case .failure(let error):
                    callback?(.message(error.localizedDescription))
                }
        })
    }
    func addtoWatchlist(id: Int,state: Bool) {
        callback?(.loading)
        AccountApiService.shared.addToWatchlist(
            requestModel: .init(
                mediaType: "movie",
                mediaId: id,
                watchlist: state
            ),
            completion: {
                [weak self] result in
                guard let self else { return }
                callback?(.loaded)
                switch result {
                    case .success(let model):
                    if model.success && model.statusMessage?.isEmpty == false{
                        self.callback?(.message(model.statusMessage!))
                        self.callback?(.reload)
                    }
                case .failure(let error):
                    self.callback?(.message(error.localizedDescription))
                }
            }
        )
    }
    func getAccountState(movieId: Int, completion: @escaping (AccountStateDto?) -> Void) {
        AccountApiService.shared.fetchUserState(movieId: movieId) { result in
            switch result {
            case .success(let dto):
                completion(dto)
            case .failure:
                completion(nil)
            }
        }
    }
}

//
//  WatchListViewModel.swift
//  FirstAPI
//
//  Created by Servan on 01.07.26.
//

import Foundation

final class WatchListViewModel: MovieListViewModel {
    
    var isWatchlist: [AccountStateDto] = []
    
    func deleteFromWatchlist(id: Int) {
        
    }
    
    var upcomingMovies: [UpcomingList] = []
    
    var topRatedMovies: [TopRatedList] = []
    
    var popularMovies: [PopularMovieList] = []
    
    var trendMovies: [TrendMovieList] = []
    
    var callback: ((MovieListViewState) -> Void)?
    
    var movies: [MovieDto] = []
    
    func getMovies() {
        getWatchlistMovies(type: .nowplaying)
        getWatchlistMovies(type: .popular)
        getWatchlistMovies(type: .topRated)
        getWatchlistMovies(type: .trend)
        getWatchlistMovies(type: .upcoming)
    }
    func addtoWatchlist(id: Int,state: Bool) {
        AccountApiService.shared.addToWatchlist(
            requestModel: .init(
                mediaType: "movie",
                mediaId: id,
                watchlist: state
            ),
            completion: {
                [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let model):
                    if model.success == true && model.statusMessage?.isEmpty == false {
                        self.callback?(.message(model.statusMessage!))
                        self.callback?(.reload)
                        
                        self.getMovies()
                       
                    }
                case .failure(let error):
                self.callback?(.message(error.localizedDescription))
                }
            }
        )
    }
    
    enum MovieListType {
        case nowplaying
        case upcoming
        case popular
        case topRated
        case trend
    }
    private func getWatchlistMovies(type: MovieListType) {
        callback?(.loading)
        switch type {
        case .nowplaying:
            AccountApiService.shared.getToWatchList(page: 1) { [weak self] (result: Result<NowPlayingDto, Error>) in
                guard let self else { return }
                self.callback?(.loaded)
                if case .success(let dto) = result {
                    self.movies = dto.results ?? []
                    self.callback?(.reload)
                } else if case .failure(_) = result {
                    self.callback?(.message("Failed to get now playing movies"))
                }
            }
        case .upcoming:
            AccountApiService.shared.getToWatchList(page: 1) { [weak self] (result: Result<UpcomingDto, Error>) in
                guard let self else { return }
                self.callback?(.loaded)
                if case .success(let dto) = result {
                    self.upcomingMovies = dto.results ?? []
                    self.callback?(.reload)
                } else if case .failure(_) = result {
                    self.callback?(.message("Failed to get upcoming movies"))
                }
            }
        case .topRated:
            AccountApiService.shared.getToWatchList(page: 1) { [weak self] (result: Result<TopRatedDto, Error>) in
                guard let self else { return }
                self.callback?(.loaded)
                if case .success(let dto) = result {
                    self.topRatedMovies = dto.results ?? []
                    self.callback?(.reload)
                } else if case .failure(_) = result {
                    self.callback?(.message("Failed to get top rated movies"))
                }
            }
        case .popular:
            AccountApiService.shared.getToWatchList(page: 1) { [weak self] (result: Result<PopularMoviesDto, Error>) in
                guard let self else { return }
                self.callback?(.loaded)
                if case .success(let dto) = result {
                    self.popularMovies = dto.results ?? []
                    self.callback?(.reload)
                } else if case .failure(_) = result {
                    self.callback?(.message("Failed to get popular movies"))
                }
            }
        case .trend:
            AccountApiService.shared.getToWatchList(page: 1) { [weak self] (result: Result<TrendMoviesDto, Error>) in
                guard let self else { return }
                self.callback?(.loaded)
                if case .success(let dto) = result {
                    self.trendMovies = dto.results ?? []
                    self.callback?(.reload)
                } else if case .failure(_) = result {
                    self.callback?(.message("Failed to get trend movies"))
                }
            }
        }
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

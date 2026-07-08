//
//  TopRatedListViewModel.swift
//  FirstAPI
//
//  Created by Servan on 02.07.26.
//

import Foundation

final class TopRatedListViewModel: MovieListViewModel {
    var callback: ((MovieListViewState) -> Void)?
    
    var movies: [MovieDto] = []
    
    var upcomingMovies: [UpcomingList] = []
    
    var topRatedMovies: [TopRatedList] = []
    
    var popularMovies: [PopularMovieList] = []
    
    var trendMovies: [TrendMovieList] = []
    
    func getMovies() {
        topRatedConfigure()
    }
    func didSelectMovie(at index: Int) {
        addtoWatchlist(id: index)
    }
     func addtoWatchlist(id: Int) {
        callback?(.loading)
        AccountApiService.shared.addToWatchlist(
            requestModel: .init(
                mediaType: "movie",
                mediaId: id,
                watchlist: true
            ),
            completion: {
                [weak self] result in
                guard let self else { return }
                callback?(.loaded)
                switch result {
                    case .success(let model):
                    if model.success && model.statusMessage?.isEmpty == false{
                        self.callback?(.message(model.statusMessage!))
                    }
                case .failure(let error):
                    self.callback?(.message(error.localizedDescription))
                }
            }
        )
    }
    func topRatedConfigure() {
        callback?(.loading)
        MovieApiService.shared.getTopRated(page: 1, completion: {
            [weak self] result in
            guard let self else { return }
            self.callback?(.loaded)
            switch result {
            case .success(let movies):
                self.topRatedMovies = movies.results ?? []
                self.callback?(.reload)
            case .failure(let error):
                callback?(.message(error.localizedDescription))
            }
        })
    }
}

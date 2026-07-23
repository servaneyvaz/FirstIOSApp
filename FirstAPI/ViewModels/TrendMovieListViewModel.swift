//
//  TrendMovieListViewModel.swift
//  FirstAPI
//
//  Created by Servan on 02.07.26.
//

import Foundation

final class TrendMovieListViewModel: MovieListViewModel {
    
    var callback: ((MovieListViewState) -> Void)?
    
    private(set) var movies: [MoviePresentable] = []
    
    func getMovies() {
        trendingMoviesConfigure()
    }
    

    
    
    func trendingMoviesConfigure() {
        callback?(.loading)
        MovieApiService.shared.getTrending(page: 1, completion: {
            [weak self] result in
            guard let self else { return }
            self.callback?(.loaded)
            switch result {
            case .success(let movies):
                self.movies = movies.results ?? []
                self.callback?(.reload)
            case .failure(let error):
                self.callback?(.message(error.localizedDescription))
            }
        })

    }
    
}

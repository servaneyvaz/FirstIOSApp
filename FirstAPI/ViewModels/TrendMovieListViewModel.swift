//
//  TrendMovieListViewModel.swift
//  FirstAPI
//
//  Created by Servan on 02.07.26.
//

import Foundation

final class TrendMovieListViewModel: MovieListViewModel {
    func getPerson() {
        getPersons()
    }
    
    var persons: [MoviePresentable] = []
    
    var callback: ((MovieListViewState) -> Void)?
    
    private(set) var movies: [MoviePresentable] = []
    
    func getMovies() {
        trendingMoviesConfigure()
    }
    

    func didSelectMovie(at index: Int) {
        addtoWatchlist(id: index)
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
                callback?(.message(error.localizedDescription))
            }
        })

    }
    
    func getPersons() {
        callback?(.loading)
        MovieApiService.shared.getPersonDetails(id: 1, completion: {
            [weak self] result in
            guard let self else { return }
            callback?(.loaded)
            
            switch result {
            case .success(let persons):
                self.persons = persons.results ?? []
                callback?(.reload)
            case .failure(let error):
                callback?(.message(error.localizedDescription))
            }
        })
    }
}

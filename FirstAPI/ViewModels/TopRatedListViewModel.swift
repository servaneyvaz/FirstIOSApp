//
//  TopRatedListViewModel.swift
//  FirstAPI
//
//  Created by Servan on 02.07.26.
//

import Foundation

final class TopRatedListViewModel: MovieListViewModel {
    func getPerson() {
        getPersons()
    }
    
    var persons: [MoviePresentable] = []
    
    var callback: ((MovieListViewState) -> Void)?
    
    private(set) var movies: [MoviePresentable] = []
    
    func getMovies() {
        topRatedConfigure()
    }
    
    func didSelectMovie(at index: Int) {
        addtoWatchlist(id: index)
    }
    
    func topRatedConfigure() {
        callback?(.loading)
        MovieApiService.shared.getTopRated(page: 1, completion: {
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

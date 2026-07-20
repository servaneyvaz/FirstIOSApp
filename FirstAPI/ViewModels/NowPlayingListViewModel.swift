//
//  Untitled.swift
//  FirstAPI
//
//  Created by Servan on 01.07.26.
//

import Foundation
final class NowPlayingListViewModel: MovieListViewModel {
    func didSelectMovie(at index: Int) {
        guard let id = movies[index].id else { return }
        addtoWatchlist(id: id)
    }
    
    var callback: ((MovieListViewState) -> Void)?
    
    private(set) var persons: [MoviePresentable] = []
    
    private(set) var movies: [MoviePresentable] = []
    
    func getMovies() {
        nowPlayingConfigure()
        
    }
    func getPerson() {
        getPersons()
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

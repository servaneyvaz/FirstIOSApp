//
//  UpcomingListViewModel.swift
//  FirstAPI
//
//  Created by Servan on 02.07.26.
//
import Foundation

final class UpcomingListViewModel: MovieListViewModel {

    var callback: ((MovieListViewState) -> Void)?
    
    private(set) var movies: [MoviePresentable] = []
    
    func getMovies() {
        upcomingConfigure()
    }
    func upcomingConfigure() {
        callback?(.loading)
        MovieApiService.shared.getUpcoming(page: 1, completion: {
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

//
//  WatchlistMovieListViewModel.swift
//  FirstAPI
//
//  Created by Servan on 21.07.26.
//

import Foundation

protocol WatchlistMovieListViewModel: AnyObject
{
    var movies: [MoviePresentable] { get }
    var callback: ((MovieListViewState) -> Void )? { get set }
    func getMovies()
    func removeMovie(id: Int)
}
extension WatchlistMovieListViewModel {
    
    func removeMovie(id: Int) {
        AccountApiService.shared.addToWatchlist(
            requestModel: .init(
                mediaType: "movie",
                mediaId: id,
                watchlist: false
            ),
            completion: {
                [weak self] result in
                guard let self else { return }
                self.callback?(.loaded)
                switch result {
                case .success(let model):
                    if model.success == true && model.statusMessage?.isEmpty == false {
                        self.callback?(.message(model.statusMessage!))
                        self.getMovies()
                        self.callback?(.reload)
                       
                    }
                case .failure(let error):
                    self.callback?(.message(error.localizedDescription))
                }
            }
        )
    }
    
}

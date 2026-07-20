//
//  MovieListViewModel.swift
//  FirstAPI
//
//  Created by Servan on 01.07.26.
//

import Foundation
enum MovieListViewState {
    case loading
    case loaded
    case reload
    case message(String)
   
}
protocol MovieListViewModel: AnyObject {
    var callback: ((MovieListViewState) -> Void )? { get set }
    func getMovies()
    func getPerson()
    
    func didSelectMovie(at index: Int)
    func addtoWatchlist(id: Int)
    var movies: [MoviePresentable] { get }
    var persons: [MoviePresentable] { get }
}
extension MovieListViewModel {
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
                self.callback?(.loaded)
                switch result {
                case .success(let model):
                    if model.success && model.statusMessage?.isEmpty == false {
                        self.callback?(.message(model.statusMessage!))
                    }
                case .failure(let error):
                    self.callback?(.message(error.localizedDescription))
                }
            }
        )
    }
}

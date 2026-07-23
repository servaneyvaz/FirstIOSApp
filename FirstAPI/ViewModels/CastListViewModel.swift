//
//  CastListViewModel.swift
//  FirstAPI
//
//  Created by Servan on 22.07.26.
//


import Foundation

protocol CastListViewModel: AnyObject {
    var callback: ((MovieListViewState) -> Void)? { get set }
    var cast: [MoviePresentable] { get }
    func getCast()
}

final class DefaultCastListViewModel: CastListViewModel {
    var callback: ((MovieListViewState) -> Void)?
    private(set) var cast: [MoviePresentable] = []

    private let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }

    func getCast() {
        callback?(.loading)
        MovieApiService.shared.getCredits(movieId: movieId) { [weak self] result in
            guard let self else { return }
            self.callback?(.loaded)
            switch result {
            case .success(let dto):
                self.cast = dto.cast?.map { $0 as MoviePresentable } ?? []
                self.callback?(.reload)
            case .failure(let error):
                self.callback?(.message(error.localizedDescription))
            }
        }
    }
}

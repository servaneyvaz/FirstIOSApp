//
//  ReviewViewModel.swift
//  FirstAPI
//
//  Created by Servan on 23.07.26.
//

import Foundation
protocol ReviewViewModel: AnyObject {
    var callback: ((MovieListViewState) -> Void)? { get set }
    var review: [MoviePresentable] { get }
    func getReviews()
}

final class DefaultReviewViewModel: ReviewViewModel {
    var callback: ((MovieListViewState) -> Void)?
    var review: [MoviePresentable] = []
    private let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }
    func getReviews() {
        callback?(.loading)
        MovieApiService.shared.getReviews(movieId: movieId) { [weak self] result in
            guard let self else { return }
            callback?(.loaded)
            switch result {
            case .success(let dto):
                self.review = dto.results?.map { $0 as MoviePresentable} ?? []
                self.callback?(.reload)
            case .failure(let error):
                self.callback?(.message(error.localizedDescription))
            }
            
        }
    }
}

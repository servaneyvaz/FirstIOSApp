//
//  MovieDetailViewModel.swift
//  FirstAPI
//
//  Created by Servan on 22.07.26.
//
import Foundation

protocol MovieDetailViewModel {
    var callback: ((MovieDetailViewState) -> Void)? { get set }

    var title: String? { get }
    var posterURL: String? { get }
    var backdropURL: String? { get }
    var ratingText: String? { get }
    var overview: String? { get }
    var releaseYear: String? { get }
    var movieId: Int? { get }
    var isInWatchlist: Bool { get }
    func toggleWatchlist()
}

enum MovieDetailViewState {
    case watchlistChanged(Bool)
    case message(String)
}

final class DefaultMovieDetailViewModel: MovieDetailViewModel {
    
    
    var callback: ((MovieDetailViewState) -> Void)?
    private(set) var isInWatchlist: Bool

    private let movie: MoviePresentable
    private let listViewModel: MovieListViewModel?
    private let watchlistModel: WatchlistMovieListViewModel?

    init(movie: MoviePresentable,
         listViewModel: MovieListViewModel?,
         watchlistModel: WatchlistMovieListViewModel?,
         isInWatchlist: Bool = false) {
        self.movie = movie
        self.listViewModel = listViewModel
        self.watchlistModel = watchlistModel
        self.isInWatchlist = isInWatchlist
    }

    var title: String? { movie.posterTitle }
    var posterURL: String? { movie.posterPathUrl }
    var backdropURL: String? { movie.backdropPathURL }
    var overview: String? { movie.aboutmovie }
    var movieId: Int? { movie.id } 
    var ratingText: String? {
        guard let rating = movie.ratingAverage else { return nil }
        return "\((rating * 10).rounded() / 10)"
    }

    var releaseYear: String? {
        movie.releaseDate?.split(separator: "-").first.map(String.init)
    }

    func toggleWatchlist() {
        guard let id = movie.id else { return }
        isInWatchlist.toggle()
        if isInWatchlist {
            listViewModel?.addtoWatchlist(id: id)
        } else {
            watchlistModel?.removeMovie(id: id)
        }
        callback?(.watchlistChanged(isInWatchlist))
    }
}

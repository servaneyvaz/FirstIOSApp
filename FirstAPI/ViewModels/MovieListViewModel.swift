//
//  MovieListViewModel.swift
//  FirstAPI
//
//  Created by Servan on 01.07.26.
//

enum MovieListViewState {
    case loading
    case loaded
    case reload
    case message(String)
}
protocol MovieListViewModel: AnyObject {
    var callback: ((MovieListViewState) -> Void )? { get set }
    var movies: [MovieDto] { get }
    var upcomingMovies: [UpcomingList] { get }
    var topRatedMovies: [TopRatedList] { get }
    var popularMovies: [PopularMovieList] { get }
    var trendMovies: [TrendMovieList] { get }
    func getMovies()
    func didSelectMovie(at index: Int)
    func addtoWatchlist(id: Int)
}

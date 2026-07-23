import Foundation
final class WatchListViewModel: WatchlistMovieListViewModel {
    var callback: ((MovieListViewState) -> Void)?
    
    private(set) var movies: [MoviePresentable] = []
    
    
    func getMovies() {
        self.movies.removeAll()
        getWatchlistMovies()
    }
    
    
    private func getWatchlistMovies() {
        callback?(.loading)
        
        AccountApiService.shared.getToWatchList(page: 1) { [weak self] (result: Result<NowPlayingDto, Error>) in
            guard let self else { return }
            self.callback?(.loaded)
            if case .success(let dto) = result {
                self.movies = dto.results ?? []
                self.callback?(.reload)
            } else if case .failure(_) = result {
                self.callback?(.message("Failed to get watchlist"))
            }
        }
    }
}

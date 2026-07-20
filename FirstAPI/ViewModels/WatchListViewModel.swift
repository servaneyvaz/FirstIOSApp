import Foundation
final class WatchListViewModel: MovieListViewModel {
    func getPerson() {
        getPersons()
    }
    
    var persons: [MoviePresentable] = []
    
    var callback: ((MovieListViewState) -> Void)?
    
    private(set) var movies: [MoviePresentable] = []
    
    func didSelectMovie(at index: Int) {
        
    }
    
    func getMovies() {
        self.movies.removeAll()
        getWatchlistMovies(type: .nowplaying)
    }
    
    func addtoWatchlist(id: Int) {
        removeMovie(id: id)
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
    
    func removeMovie(id: Int) {
        AccountApiService.shared.addToWatchlist(
            requestModel: .init(
                mediaType: "movie",
                mediaId: id,
                watchlist: false
            ),
            completion: { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let model):
                    if model.success == true && model.statusMessage?.isEmpty == false {
                        self.callback?(.message(model.statusMessage!))
                        self.callback?(.reload)
                        
                        self.getMovies()
                       
                    }
                case .failure(let error):
                    self.callback?(.message(error.localizedDescription))
                }
            }
        )
    }
    
    enum MovieListType {
        case nowplaying
        case upcoming
        case popular
        case topRated
        case trend
    }
    private func getWatchlistMovies(type: MovieListType) {
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

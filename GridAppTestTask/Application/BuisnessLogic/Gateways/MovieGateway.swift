import Foundation

protocol MovieGateway {
    func loadList(page: Int, completion: @escaping (Result<ListResultModel, Error>) -> Void)
}

class MovieGatewayImpl: MovieGateway {
    
    private let api: ApiMovieGateway
    
    init(api: ApiMovieGateway) {
        self.api = api
    }
    
    func loadList(page: Int, completion: @escaping (Result<ListResultModel, Error>) -> Void) {
        api.loadList(page: page, completion: completion)
    }
}

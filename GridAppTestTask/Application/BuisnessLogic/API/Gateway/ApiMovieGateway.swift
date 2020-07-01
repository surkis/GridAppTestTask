import Foundation

protocol ApiMovieGateway {
    func loadList(page: Int, completion: @escaping (Result<Void, Error>) -> Void)
}

class ApiMovieGatewayImpl: ApiMovieGateway {
    
    private var apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func loadList(page: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
}

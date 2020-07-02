import Foundation

protocol ApiMovieGateway {
    func loadList(page: Int, completion: @escaping (Result<ListResultModel, Error>) -> Void)
}

class ApiMovieGatewayImpl: ApiMovieGateway {
    
    private var apiClient: ApiClient
    
    init(apiClient: ApiClient = ApiClientImpl()) {
        self.apiClient = apiClient
    }
    
    func loadList(page: Int, completion: @escaping (Result<ListResultModel, Error>) -> Void) {
        let resqust = ApiNowPlayingRequest(page: page)
        apiClient.execute(request: resqust) { (result: Result<ApiResponse<ApiListResultModel>, Error>) in
            do {
                let list = try result.get()
                completion(.success(list.entity.asDomain()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

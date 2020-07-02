import Foundation

struct ApiNowPlayingRequest: ApiRequest {
    var page: Int
    
    init(page: Int = 1) {
        self.page = page
    }
    
    var urlRequest: URLRequest {
        let url = Constants.API.baseURL.appendingPathComponent("movie/now_playing")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.API.apiKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        var request = URLRequest(url: components.url!)
        
        request.httpMethod = "GET"
        
        return request
    }
}

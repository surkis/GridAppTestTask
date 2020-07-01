import Foundation

enum ApiError {
    case networkError(Error)
    case dataNotFound
    case networkRequestError(Error?)
    case dataNotParse
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return error.localizedDescription
        case .dataNotFound:
            return R.string.localizable.error_api_data_not_found()
        case .networkRequestError(let error):
            return error?.localizedDescription ?? R.string.localizable.error_api_network_request()
        case .dataNotParse:
            return R.string.localizable.error_api_data_not_parsing()
        }
    }
}

struct ApiParseError: Error {
    static let code = 999
    
    let error: Error
    let urlResponse: URLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}

struct NetworkApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

import Foundation

protocol ApiClient {
    func execute<T: Decodable>(request: ApiRequest,
                               completionHandler: @escaping (_ result: Result<ApiResponse<T>, Error>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class ApiClientImpl: ApiClient {
    
    let urlSession: URLSessionProtocol
    
    #if DEBUG
    let isDebugMode = true
    #else
    let isDebugMode = false
    #endif
    private let logName: String = "\n*** [ApiClientImpl] "
    
    init(urlSessionConfiguration: URLSessionConfiguration = .default,
         completionHandlerQueue: OperationQueue = .main) {
        urlSession = URLSession(configuration: urlSessionConfiguration,
                                delegate: nil, delegateQueue: completionHandlerQueue)
    }
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func execute<T: Decodable>(request: ApiRequest,
                               completionHandler: @escaping (Result<ApiResponse<T>, Error>) -> Void) {
        let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            
            if self.isDebugMode {
                if let data = data {
                    print("request responce body \(String(data: data, encoding: String.Encoding.utf8) ?? "")")
                    print("=============\n")
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            guard let urlResponse = response else {
                completionHandler(.failure(ApiError.networkRequestError(error)))
                return
            }
            do {
                let apiResponse = try ApiResponse<T>(data: data, urlResponse: urlResponse)
                completionHandler(.success(apiResponse))
            } catch {
                completionHandler(.failure(error))
            }
        }
        if isDebugMode {
            print("\(logName) request request \(request.urlRequest.description)")
            debugPrint(request)
        }
        
        dataTask.resume()
    }
}

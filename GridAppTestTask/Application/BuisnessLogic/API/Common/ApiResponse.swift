import Foundation

struct ApiResponse<Response: Decodable> {
    let entity: Response
    let urlResponse: URLResponse
    let data: Data?
    
    init(data: Data?, urlResponse: URLResponse) throws {
        self.data = data
        self.urlResponse = urlResponse
        guard let data = data else {
            throw ApiError.dataNotFound
        }
        do {
            self.entity = try JSONDecoder().decode(Response.self, from: data)
        } catch {
            throw ApiParseError(error: error, urlResponse: urlResponse, data: data)
        }
    }
}

struct VoidResponse: Decodable {
    
}

struct HTMLCodeResponse: Decodable {
    var content: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        content = try container.decode(String.self)
    }
}

import Foundation

protocol ApiDecodable {
    static func decode(data: Data) throws -> Self
}

struct ApiResponse<Response: ApiDecodable> {
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
            self.entity = try Response.decode(data: data)
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

import Foundation

struct ApiListResultModel: Decodable {
    var results: [ApiMovieModel]
    var page: Int
    var totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
    }
}

extension ApiListResultModel: ApiDecodable {
    
    static func decode(data: Data) throws -> ApiListResultModel {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(ApiMovieModel.dateFormatter)
        return try decoder.decode(ApiListResultModel.self, from: data)
    }
}

extension ApiListResultModel: DomainConvertibleType {
    
    func asDomain() -> ListResultModel {
        return ListResultModel(
            results: results.map({$0.asDomain()}),
            page: page,
            totalPages: totalPages
        )
    }
}

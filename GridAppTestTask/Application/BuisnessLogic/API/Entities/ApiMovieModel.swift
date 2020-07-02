import Foundation

struct ApiMovieModel: Decodable {
    
    var identifier: Int
    var title: String
    var overview: String
    var voteAverage: Double
    var releaseDate: Date
    var posterPath: String?
    var isAdult: Bool
    var isVideo: Bool
    var backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case isAdult = "adult"
        case isVideo = "video"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(Int.self, forKey: .identifier)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        releaseDate = try container.decode(Date.self, forKey: .releaseDate)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        isAdult = try container.decode(Bool.self, forKey: .isAdult)
        isVideo = try container.decode(Bool.self, forKey: .isVideo)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    }
    
    var posterURL: URL? {
        if let path = posterPath {
            return Constants.API.posterURL.appendingPathComponent(path)
        }
        return nil
    }
}

extension ApiMovieModel: ApiDecodable {
    
    static let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"
      return dateFormatter
    }()
    
    static func decode(data: Data) throws -> ApiMovieModel {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(ApiMovieModel.self, from: data)
    }
}

extension ApiMovieModel: DomainConvertibleType {
    
    func asDomain() -> MovieModel {
        return MovieModel(
            identifier: identifier,
            title: title,
            overview: overview,
            releaseDate: releaseDate,
            posterURL: posterURL,
            isAdult: isAdult,
            isVideo: isVideo,
            backdropPath: backdropPath,
            voteAverage: voteAverage
        )
    }
}

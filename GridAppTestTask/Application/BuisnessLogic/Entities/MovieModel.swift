import Foundation

struct MovieModel {
    var identifier: Int
    var title: String
    var overview: String
    var releaseDate: Date
    var posterURL: URL?
    var isAdult: Bool
    var isVideo: Bool
    var backdropPath: String?
    var voteAverage: Double
}

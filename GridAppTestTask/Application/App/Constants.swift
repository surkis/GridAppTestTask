import Foundation

struct Constants {
    
    enum API {
        static var baseURL: URL = URL(string: "https://api.themoviedb.org/3")!
        static var apiKey: String = "ebea8cfca72fdff8d2624ad7bbf78e4c"
        static var posterURL: URL = URL(string: "https://image.tmdb.org/t/p/w500")!
    }
}

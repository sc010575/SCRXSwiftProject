import Foundation

struct MovieDetail : Codable {
    let backdropPath:String
    let overview:String
    let budget:Int
    let homepage: String?
    let originalTitle:String
    let releaseDate:String
    let voteAverage:Float
    let voteCount:Int
    let productionCompanies: [Production]
    static let emptyMovieDetails = MovieDetail(backdropPath: "", overview: "", budget: 0, homepage: "", originalTitle: "", releaseDate: "",voteAverage:0,voteCount:0, productionCompanies: [])

}

struct Production:Codable {
    let id : Int
    let logoPath:String?
    let name:String
    let originCountry:String
}

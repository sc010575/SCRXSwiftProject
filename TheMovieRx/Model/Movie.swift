import Foundation

/*
 "page": 1,
 "total_results": 19837,
 "total_pages": 992,
 "results": [
 {
 "vote_count": 2827,
 "id": 335983,
 "video": false,
 "vote_average": 6.5,
 "title": "Venom",
 "popularity": 415.772,
 "poster_path": "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
 "original_language": "en",
 "original_title": "Venom",
 "genre_ids": [
 878
 ],
 "backdrop_path": "/VuukZLgaCrho2Ar8Scl9HtV3yD.jpg",
 "adult": false,
 "overview": "Eddie Brock is a reporter—investigating people who want to go unnoticed. But after he makes a terrible discovery at the Life Foundation, he begins to transform into ‘Venom’.  The Foundation has discovered creatures called symbiotes, and believes they’re the key to the next step in human evolution. Unwittingly bonded with one, Eddie discovers he has incredible new abilities—and a voice in his head that’s telling him to embrace the darkness.",
 "release_date": "2018-10-03"
 */

struct Movie:Codable {
    let results:[Result]    
    static let emptyMovie = Movie(results: [])
}

struct Result :Codable {
    let id:Int
    let voteCount:Int
    let voteAverage:Float
    let title:String
    let popularity:Double
    let posterPath:String
    let backdropPath:String
    let overview:String
    let releaseDate:String
}

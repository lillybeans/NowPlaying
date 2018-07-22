//
//  Movie.swift
//  NowPlaying
//
//  Created by Lilly Tong on 2018-07-19.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

struct Movie : Codable {
    let id: Double
    let title : String
    let overview : String
    let releaseDate : String
    let voteAverage: Double
    let posterPath : String
    
    private enum CodingKeys : String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
    
}

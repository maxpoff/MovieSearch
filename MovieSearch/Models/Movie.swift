//
//  Movie.swift
//  MovieSearch
//
//  Created by Maxwell Poffenbarger on 1/24/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import Foundation

struct TopLevelObject: Codable {
    
    let results: [Movie]
    
}//End of struct

struct Movie: Codable {
    
    let rating: Double
    let title: String
    let summary: String
    let image: String?
    let releaseDate: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case title = "original_title"
        case summary = "overview"
        case image = "poster_path"
        case releaseDate = "release_date"
        case id
    }
}//End of struct

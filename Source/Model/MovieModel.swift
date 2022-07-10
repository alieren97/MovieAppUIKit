//
//  Movie.swift
//  MovieApp
//
//  Created by AliEren on 3.06.2022.
//

import Foundation
import UIKit

struct MovieResponse: Codable {
    var search: [MovieModel]
    let totalResults, response: String
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
    
}

struct MovieModel: Codable {
    let title, year, imdbID: String?
    let type: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

//
//  Album.swift
//  TopBops
//
//  Created by Moses Robinson on 5/2/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    let albumName: String
    let artistName: String
    let genres: [Genre]
    let releaseDate: String
    let copyright: String
    let artworkURL: URL
    let itunesURL: URL
    
    struct Genre: Codable {
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case albumName = "name"
        case artistName
        case genres
        case releaseDate
        case copyright
        case artworkURL = "artworkUrl100"
        case itunesURL = "url"
    }
}

struct Albums: Codable {
    let results: [Album]
}

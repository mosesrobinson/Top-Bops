//
//  AlbumController.swift
//  TopBops
//
//  Created by Moses Robinson on 5/2/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

class AlbumController {
    
    func fetchTopTenAlbums(completion: @escaping (Error?) -> Void) {
        
        let url = baseURL.appendingPathComponent("explicit").appendingPathExtension("json")
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                NSLog("Error retrieving JSON: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let decodedDictionary = try jsonDecoder.decode(JSON.self, from: data)
                let decodedAlbums = decodedDictionary.feed.results
                
                self.albums = decodedAlbums
                completion(nil)
            } catch {
                NSLog("Error decoding data.")
                completion(error)
                return
            }
        }
        dataTask.resume()
    }
    
    func fetchImage(album: Album, completion: @escaping (Data?, Error?) -> Void) {
        
        let artworkURL = album.artworkURL
        
        let dataTask = URLSession.shared.dataTask(with: artworkURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error found while fetching from URL: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data found from URL.")
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        dataTask.resume()
    }
    
    //MARK: - Properties
    
    private let baseURL = URL(string: "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-albums/all/10")!
    private(set) var albums: [Album] = []
    
}

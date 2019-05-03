//
//  FetchPhotoOperation.swift
//  TopBops
//
//  Created by Moses Robinson on 5/3/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class FetchPhotoOperation: ConcurrentOperation {
    
    init(album: Album, session: URLSession = URLSession.shared) {
        self.album = album
        self.session = session
        super.init()
    }
    
    override func start() {
        state = .isExecuting
        
        let url = album.artworkURL
        
        let task = session.dataTask(with: url) { (data, _, error) in
            
            defer { self.state = .isFinished }
            if self.isCancelled { return }
            
            if let error = error {
                NSLog("Error fetching data for \(self.album): \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data found")
                return
            }
            
            guard let image = UIImage(data: data) else {
                NSLog("Could not construct image from data")
                return
            }
            
            self.image = image
        }
        task.resume()
        dataTask = task
    }
    
    override func cancel() {
        super.cancel()
        dataTask?.cancel()
    }
    
    //MARK: - Properties
    
    let album: Album
    private let session: URLSession
    private(set) var image: UIImage?
    private var dataTask: URLSessionDataTask?
}


//
//  AlbumTableViewCell.swift
//  TopBops
//
//  Created by Moses Robinson on 5/2/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    private func updateViews() {
        
        guard let album = album else { return }
        
        albumNameLabel.text = album.albumName
        artistNameLabel.text = album.artistName
    }
    
    //MARK: - Properties
    
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
}

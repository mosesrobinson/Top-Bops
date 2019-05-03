//
//  AlbumDetailViewController.swift
//  TopBops
//
//  Created by Moses Robinson on 5/2/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setUpAppearance()
    }
    
    @IBAction func purchaseOnItunesTapped(_ sender: Any) {
        
        guard let album = album else { return }
        let url = album.itunesURL
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //MARK: - Private Methods
    
    private func updateViews() {
        
        guard let album = album, isViewLoaded else { return }
        
        albumNameLabel.text = album.albumName
        artistNameLabel.text = album.artistName
        
        let genres = album.genres
        let genre = genres.first?.name
        
        genreLabel.text = genre
        releaseDateLabel.text = album.releaseDate
        copyrightLabel.text = album.copyright
        
        albumController?.fetchImage(album: album, completion: { (data, _) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.artworkImageView.image = UIImage(data: data)
            }
        })
    }
    
    private func setUpAppearance() {
        
        navigationController?.navigationBar.shadowImage = UIImage()
        purchaseButton.layer.cornerRadius = 10
        artworkImageView.layer.cornerRadius = 8
        genreAndDateContainer.layer.cornerRadius = 8
        containerView.backgroundColor = AppearanceHelper.softOrange
    }
    
    //MARK: - Properties
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var genreAndDateContainer: UIView!
}

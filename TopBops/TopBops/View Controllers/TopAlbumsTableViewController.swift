//
//  TopAlbumsTableViewController.swift
//  TopBops
//
//  Created by Moses Robinson on 5/2/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class TopAlbumsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController.fetchTopTenAlbums { (error) in
            
            if let error = error {
                NSLog("Unable to fetch albums from RSS Feed: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        
        let album = albumController.albums[indexPath.row]
        cell.album = album
        loadImage(forCell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    //MARK: - Private Methods
    
    private func loadImage(forCell cell: AlbumTableViewCell, forItemAt indexPath: IndexPath) {
        
        let album = albumController.albums[indexPath.row]
        
        albumController.fetchImage(album: album, completion: { (data, _) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                cell.thumbnailImageView.image = UIImage(data: data)
            }
        })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowAlbumDetail" {
            guard let destination = segue.destination as? AlbumDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let album = albumController.albums[indexPath.row]
            
            destination.album = album
            destination.albumController = albumController
        }
    }
    
    // MARK: - Properties
    
    let albumController = AlbumController()
    
}

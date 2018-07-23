//
//  MovieCollectionViewCell.swift
//  NowPlaying
//
//  Created by Lilly Tong on 2018-07-20.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var votedAverageLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favoriteOn : Bool = false
    
    var movie : Movie? {
        didSet {
            setupUI()
        }
    }
    
    func setupUI(){
        guard let movie = movie else { return }
        
        favoriteOn = false
            
        APIRequests.getPoster(with: movie.posterPath,completionHandler: { [weak self] (image:UIImage?) in
            self?.posterImage.image = image
        })
        
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview
        votedAverageLabel.text = String(movie.voteAverage)
        
        //Check if movie is favorited
        if UserDefaults.standard.object(forKey: "\(movie.id)") != nil {
            favoriteButton.setImage(UIImage(named: "heart-filled"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "heart-empty"), for: .normal)
        }
    }
    
    @IBAction func toggleFavorite(_ sender: Any) {
        favoriteOn = !favoriteOn
        
        guard let movieId = movie?.id else { return }
        
        if favoriteOn {
            favoriteButton.setImage(UIImage(named: "heart-filled"), for: .normal)
            UserDefaults.standard.set(true, forKey: "\(movieId)") //save favorited movie
        } else {
            favoriteButton.setImage(UIImage(named: "heart-empty"), for: .normal)
            UserDefaults.standard.removeObject(forKey: "\(movieId)") //un-save favorited movie
        }
    }
}

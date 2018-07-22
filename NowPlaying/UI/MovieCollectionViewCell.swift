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
    
    var movie : Movie? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        if let movie = movie {
            
            APIRequests.getPoster(with: movie.posterPath,completionHandler: { [weak self] (image:UIImage?) in
                self?.posterImage.image = image
            })
            
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            votedAverageLabel.text = String(movie.voteAverage)
        }
    }
}

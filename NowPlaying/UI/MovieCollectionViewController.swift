//
//  MovieCollectionViewController.swift
//  NowPlaying
//
//  Created by Lilly Tong on 2018-07-19.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

import UIKit

class MovieCollectionViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var movies : [Movie] = []
    
    //Constants
    let movieCellReuseIdentifier = "MovieCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let cellWidth = view.bounds.width * 0.7
        let cellHeight = view.bounds.height * 0.8
        let insetX = (view.bounds.width - cellWidth) / 2
        let insetY = (view.bounds.height - cellHeight) / 2
        
        moviesCollectionView.contentInset = UIEdgeInsetsMake(insetY, insetX, insetY, insetX) //Top, left, bottom, right paddings
        
        displayNowPlaying()
       
    }
    
    @IBAction func segmentControlTapped(_ sender: Any) {
        switch (segmentControl.selectedSegmentIndex) {
        case 0 :
            displayNowPlaying()
        case 1 :
            displayTopRated()
        default:
            return
        }
    }
    
    func displayNowPlaying() {
        APIRequests.getNowPlaying(completionHandler: { [weak self] movies in
            self?.movies = movies
            self?.moviesCollectionView.reloadData()
        })
    }
    
    func displayTopRated(){
        APIRequests.getTopRated(completionHandler: { [weak self] movies in
            self?.movies = movies
            self?.moviesCollectionView.reloadData()
        })
    }
    
}

extension MovieCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellReuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        cell.movie = movies[indexPath.item]
        return cell
    }
    
}

extension MovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    //Recalculate layout when device orientation changes
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        moviesCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width * 0.7, height: view.bounds.height * 0.8)
    }
}

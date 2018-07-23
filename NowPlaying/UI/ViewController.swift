//
//  ViewController.swift
//  NowPlaying
//
//  Created by Lilly Tong on 2018-07-19.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var movies : [Movie] = []
    
    //Constants
    let movieCellReuseIdentifier = "MovieCell"
    private let cellHorizontalScaling : CGFloat = 0.7
    private let cellVerticalScaling : CGFloat = 0.8

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let cellWidth = view.bounds.width * cellHorizontalScaling
        let cellHeight = view.bounds.height * cellVerticalScaling
        let insetX = (view.bounds.width - cellWidth) / 2
        let insetY = (view.bounds.height - cellHeight) / 2
        
        let layout = moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
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

extension ViewController: UICollectionViewDataSource {
    
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


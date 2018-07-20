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
    var movies : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequests.getNowPlaying(completionHandler: { [weak self] myMovies in
            print(myMovies)
        })
       
//        APIRequests.getPoster(with: "/c9XxwwhPHdaImA2f1WEfEsbhaFB.jpg",completionHandler: { [weak self] (image:UIImage?) in
//            self?.imageView.image = image
//        })
        
//
//        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=ddda5dbdc67ad28441e0cecfa7fe6e68&language=en-US&page=1")
//        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if error != nil {
//                print(error!)
//            } else {
//                if let data = data {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
//                        if let names = json["results"] as? [Any] {
//                            print(names)
//                        }
//                    } catch let error as NSError {
//                        print("Failed to load: \(error.localizedDescription)")
//                    }
//                }
//            }
//
//        }
//        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


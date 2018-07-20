//
//  APIRequests.swift
//  NowPlaying
//
//  Created by Lilly Tong on 2018-07-19.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

import Alamofire
import UIKit

class APIRequests {
    
    //Constants base URLs and API KEY for fetching data from the network
    static private let BASE_URL : String = "https://api.themoviedb.org/3"
    static private let IMAGES_BASE_URL : String = "https://image.tmdb.org/t/p/original"
    static private let API_KEY : String = "ddda5dbdc67ad28441e0cecfa7fe6e68"
    
    static private let imageCache = NSCache<NSString, UIImage>()
    
    static func getNowPlaying(completionHandler: @escaping(([Movie]) -> ())){
        let endpoint : String = "/movie/now_playing"
        let params : [String:Any] = ["api_key": API_KEY,
                                     "language": "en-US",
                                     "page": 1]
        let decoder = JSONDecoder()

        Alamofire.request(BASE_URL + endpoint, method: .get, parameters: params).responseJSON { (response) in
            //We only need to map a nested part of the response
            guard let response = response.result.value as? [String:Any],
                let results = response["results"] else { return }
            guard let data = try? JSONSerialization.data(withJSONObject: results) else { //Convert to object before decoding
                print("Error: Cannot deserialize response")
                return
            }
            guard let movies = try? decoder.decode([Movie].self, from: data) else {
                print("Error: Cannot decode response into movies!")
                return
            }
            completionHandler(movies)
        }
    }
    
    static func getPoster(with path: String, completionHandler: @escaping((UIImage?) -> ())) {

        //1. First check if image exists in cache
        if let cachedImage = imageCache.object(forKey: path as NSString) {
            completionHandler(cachedImage)
            return
        }
        
        //2. If image not found in cache, download it
        let params : [String:Any] = ["api_key": API_KEY]
        
        Alamofire.request(IMAGES_BASE_URL + path, method: .get, parameters: params).response { response in
            var image: UIImage?
            if let data = response.data {
                image = UIImage(data: data)
                if image != nil {
                    imageCache.setObject(image!, forKey: path as NSString)
                }
            }
            completionHandler(image)
        }
    }
}

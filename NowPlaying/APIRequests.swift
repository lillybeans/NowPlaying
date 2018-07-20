//
//  APIRequests.swift
//  NowPlaying
//
//  Created by Lilly Tong on 2018-07-19.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

import CodableAlamofire
import Alamofire
import UIKit

class APIRequests {
    
    static private let BASE_URL : String = "https://api.themoviedb.org/3"
    static private let IMAGES_BASE_URL : String = "https://image.tmdb.org/t/p/original"
    static private let API_KEY : String = "ddda5dbdc67ad28441e0cecfa7fe6e68"
    
    static func getNowPlaying(completionHandler: @escaping(([Movie]) -> ())){
        let endpoint : String = "/movie/now_playing"
        let params : [String:Any] = ["api_key": API_KEY,
                                        "language": "en-US",
                                        "page": 1]
        let decoder = JSONDecoder()

        Alamofire.request(BASE_URL + endpoint, method: .get, parameters: params).responseJSON { (response) in
            
            //We only need to decode a nested part of the response, not the entire response, so we
            //must extract the relevant part of the response and decode that.
            guard let response = response.result.value as? [String:Any],
                let results = response["results"] else { return }
            guard let data = try? JSONSerialization.data(withJSONObject: results) else {
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
        let params : [String:Any] = ["api_key": API_KEY]
        var image: UIImage?

        Alamofire.request(IMAGES_BASE_URL + path, method: .get, parameters: params).response { response in
            if let data = response.data {
                image = UIImage(data: data)
            }
            completionHandler(image)
        }
    }
}

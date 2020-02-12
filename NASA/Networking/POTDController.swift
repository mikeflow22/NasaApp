//
//  POTDController.swift
//  NASA
//
//  Created by Michael Flowers on 2/12/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class POTDController {
    static let shared = POTDController()
    
    func fetchPOTDImageURL(completion: @escaping (URL?, Error?) -> Void){
        let url = URL(string: "https://api.nasa.gov/planetary/apod?&api_key=aYKRFB8IzCiFOH7cnIpP1cgONxxXUNpHeBFL85CB")!
        
        URLSession.shared.dataTask(with: url) { (date, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Response in fetchPOTDImageURL(completion): \(response.statusCode)")
            }
            
            if let error = error {
                print("Error in file: \(#file) in the body of the function: \(#function)\n on line: \(#line)\n Readable Error: \(error.localizedDescription)\n Technical Error: \(error)\n")
                completion(nil, error)
                return
            }
            
            guard let data = date else {
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                completion(nil, NSError(domain: "bhhbhhbhbhhbbhbhbhh", code: 333, userInfo: nil))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let imageURL = try decoder.decode(PictureOfTheDay.self, from: data).url
                completion(imageURL, nil)
            } catch  {
                print("Error in: \(#function)\n Readable Error: \(error.localizedDescription)\n Technical Error: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping(UIImage?, Error?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Response in fetchImage(url:completion): \(response.statusCode)")
            }
            if let error = error {
                print("Error in file: \(#file) in the body of the function: \(#function)\n on line: \(#line)\n Readable Error: \(error.localizedDescription)\n Technical Error: \(error)\n")
               completion(nil,error)
                return
            }
            
            guard let data = data else {
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                completion(nil, NSError(domain: "donaodon", code: 333, userInfo: nil))
                return
            }
            
            let image = UIImage(data: data)
            print("image description: \(String(describing: image?.description))")
            completion(image, nil)
        }.resume()
        
    }
}

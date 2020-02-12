//
//  MarsRoverClient.swift
//  NASA
//
//  Created by Michael Flowers on 2/11/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class MarsRoverClient {
    private let baseURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers")!
    private let apiKey = "aYKRFB8IzCiFOH7cnIpP1cgONxxXUNpHeBFL85CB"

   private func fetch<T: Codable>(from url: URL, using session: URLSession = URLSession.shared, completion: @escaping (T?, Error?) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "com.LambdaSchool.Astronomy.ErrorDomain", code: -1, userInfo: nil))
                return
            }
            
            do {
                let jsonDecoder = MarsPhotoReference.jsonDecoder
                let decodedObject = try jsonDecoder.decode(T.self, from: data)
                completion(decodedObject, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    //get information from the rover
    private func url(forInfoForRover roverName: String) -> URL {
        var url = baseURL
        url.appendPathComponent("manifests")
        url.appendPathComponent(roverName)
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return urlComponents.url!
    }
    
    //we just want to get the photos
    private func url(forPhotosfromRover roverName: String, on sol: Int) -> URL {
        var url = baseURL
        url.appendPathComponent("rovers")
        url.appendPathComponent(roverName)
        url.appendPathComponent("photos")
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [URLQueryItem(name: "sol", value: String(sol)),
                                    URLQueryItem(name: "api_key", value: apiKey)]
        return urlComponents.url!
    }
    
    //fetch mars rover with name of the rover
    func fetchMarsRover(named name: String, using session: URLSession = URLSession.shared, completion: @escaping (MarsRover?, Error?) -> Void) {
        
        let url = self.url(forInfoForRover: name)
        fetch(from: url, using: session) { (dictionary: [String : MarsRover]?, error: Error?) in
            guard let rover = dictionary?["photo_manifest"] else {
                completion(nil, error)
                return
            }
            completion(rover, nil)
        }
    }
    
    //use the rover we fetched to then fetch the imageURL  inside the "photos" array in the MarsPhotoReference file
    func fetchPhotos(from rover: MarsRover, onSol sol: Int, using session: URLSession = URLSession.shared, completion: @escaping ([MarsPhotoReference]?, Error?) -> Void) {
        //construct the url
        let url = self.url(forPhotosfromRover: rover.name, on: sol)
        //the dictionary  is string to any but we want our model which is an array of photos
        fetch(from: url, using: session) { (dictionary: [String : [MarsPhotoReference]]?, error: Error?) in
            guard let photos = dictionary?["photos"] else {
                completion(nil, error)
                return
            }
            completion(photos, nil)
        }
    }
    
}

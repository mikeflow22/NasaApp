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
    
    func fetchEarthView(lon: Double, lat: Double, completion: @escaping(UIImage?) -> Void){
        let baseURL = URL(string: "https://api.nasa.gov/planetary/earth/imagery")!
       
        let date = Date()
        print(date)
        let formattedDate = date.turnDateIntoString()
     print("this is the date formatted: \(formattedDate)")
        //the today's date doesn't work, or maybe it does and the  lat long  doesnt work. 
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [URLQueryItem(name: "lon", value: "\(lon)"),
                                     URLQueryItem(name: "lat", value: "\(lat)"),
                                     URLQueryItem(name: "date", value: formattedDate),
                                     URLQueryItem(name: "cloud_score", value: "True"),
                                     URLQueryItem(name: "api_key", value: apiKey)]
        
        let finalURL = urlComponents.url!
        print("earth view final url:  \(finalURL)")
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Response: \(response.statusCode)")
            }
            
               if let error = error {
                         print("Error with poster: \(error), READABLE ERROR:::\(error.localizedDescription), \(#function)")
                         completion(nil)
                         return
                     }
                     
            
                     guard let data = data else {
                         print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                         completion(nil)
                         return
                     }
                     
                     let image = UIImage(data: data)
                     completion(image)
        }.resume()
    }
}
extension Date {
    func formatDate() -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}

extension Date {
func turnDateIntoString() -> String {
    let dateformatter = DateFormatter()
    dateformatter.timeStyle = .none
    dateformatter.dateStyle = .none
    dateformatter.dateFormat = "yyyy-MM-dd"
   return dateformatter.string(from: self)
    }
}

//
//  MarsRover.swift
//  NASA
//
//  Created by Michael Flowers on 2/11/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import Foundation

//MAIN MODEL
struct MarsRover: Codable {
    let name: String
    let launchDate: Date
    let landingDate: Date
    let maxSol: Int
    let maxDate: Date
    let numberOfPhotos: Int
    let solDescriptions: [SolDescription]
    
    //this is for the operations
//    enum Status: String, Codable {
//        case active, complete
//    }
//    let status: Status
    
    //using coding keys to match numberOfPhotos to the api's documentation of totalPhotos and solDescriptions
    enum CodingKeys: String, CodingKey {
        case name
        case launchDate
        case landingDate
        case status
        case maxSol
        case maxDate
        case numberOfPhotos = "totalPhotos"
        case solDescriptions = "photos"
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static var jsonDecoder: JSONDecoder {
        let result = JSONDecoder()
        result.keyDecodingStrategy = .convertFromSnakeCase
        result.dateDecodingStrategy = .formatted(dateFormatter)
        return result
    }
}

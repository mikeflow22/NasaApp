//
//  SolDescription.swift
//  NASA
//
//  Created by Michael Flowers on 2/11/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import Foundation

struct SolDescription: Codable {
    let sol: Int //mars' day number
    let totalPhotos: Int
    let cameras: [String] //names of the cameras
}


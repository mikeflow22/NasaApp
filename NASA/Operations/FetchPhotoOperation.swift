//
//  FetchPhotoOperation.swift
//  NASA
//
//  Created by Michael Flowers on 2/12/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class FetchPhotoOperation: ConcurrentOperation {
    
    var marsPhotoReference: MarsPhotoReference
    var imageData: Data?
    private var dataTask: URLSessionDataTask?
    
    init(marsPhotoReference: MarsPhotoReference) { //pass the person in here
        self.marsPhotoReference = marsPhotoReference
    }
    
    override func start() {
        state = .isExecuting
        
        guard let url = marsPhotoReference.imageURL.usingHTTPS else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error getting image: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data found")
                return
            }
            
            self.imageData = data
            defer { self.state = .isFinished }
        }
        
        dataTask.resume()
    }
    
    override func cancel() {
        dataTask?.cancel()
    }
    
}


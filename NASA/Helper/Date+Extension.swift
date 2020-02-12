//
//  Date+Extension.swift
//  NASA
//
//  Created by Michael Flowers on 2/12/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import Foundation

extension Date {
    func turnDateIntoString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.timeStyle = .none
        dateformatter.dateStyle = .none
        dateformatter.dateFormat = "yyyy-MM-dd"
        return dateformatter.string(from: self)
    }
}

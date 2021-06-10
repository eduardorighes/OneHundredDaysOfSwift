//
//  Person.swift
//  Project10
//
//  Created by Eduardo Maestri Righes on 04/06/2021.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}

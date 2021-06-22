//
//  Capital.swift
//  Project16
//
//  Created by Eduardo Maestri Righes on 21/06/2021.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var wikiURL: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, url wiki: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.wikiURL = wiki
    }
}

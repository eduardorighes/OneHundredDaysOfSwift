//
//  Country.swift
//  CountryFacts
//
//  Created by Eduardo Maestri Righes on 20/06/2021.
//

import Foundation

struct Country: Codable {
    var name: String
    var language: String
    var population: Int
    var currency: String
    var flag: String
    var locale: String
}

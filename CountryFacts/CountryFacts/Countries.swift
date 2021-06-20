//
//  Countries.swift
//  CountryFacts
//
//  Created by Eduardo Maestri Righes on 20/06/2021.
//

import Foundation

//
// This struct is only for complying with the Codable protocol
// Used when calling JSONDecoder.decode(). E.g. Countries.self.
//

struct Countries: Codable {
    var countries: [Country]
}

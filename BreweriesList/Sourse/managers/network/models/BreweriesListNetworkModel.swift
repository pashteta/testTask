//
//  BreweriesListViewModel.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

class BreweriesListNetworkModel: Codable {
    var id: Int?
    var name: String?
    var breweryType: String?
    var street: String?
    var city: String?
    var state: String?
    var postalCode: String?
    var country: String?
    var longitude: String?
    var latitude: String?
    var phone: String?
    var websiteUrl: String?
    var updatedAt: String?
    var tagList: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case breweryType = "brewery_type"
        case street
        case city
        case state
        case postalCode = "postal_code"
        case country
        case longitude
        case latitude
        case phone
        case websiteUrl = "website_url"
        case updatedAt = "updated_at"
        case tagList = "tag_list"
    }
}


//
//  BreweriesViewModel.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class BreweriesListViewModel: Codable {
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
    var breweryHeight: CGFloat = 240.0
    
    private var stackViewLabelHeight = CGFloat(20.5)
    
    init(_ model: BreweriesListNetworkModel) {
        self.id = model.id
        self.name = model.name

        if let breweryType = model.breweryType, breweryType.hasChars() {
            self.breweryType = breweryType
        }
        
        if let street = model.street, street.hasChars() {
            self.street = street
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let city = model.city, city.hasChars() {
            self.city = model.city
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let state = model.state, state.hasChars() {
            self.state = state
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let postalCode = model.postalCode, postalCode.hasChars() {
            self.postalCode = postalCode
        }
        
        if let country = model.country, country.hasChars() {
            self.country = country
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let longitude = model.longitude, longitude.hasChars() {
            self.longitude = longitude
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let latitude = model.latitude, latitude.hasChars() {
            self.latitude = latitude
        }
        
        if let phone = model.phone, phone.hasChars() {
            self.phone = phone
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let websiteUrl = model.websiteUrl, websiteUrl.hasChars() {
            self.websiteUrl = websiteUrl
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let updatedAt = model.updatedAt, updatedAt.hasChars() {
            self.updatedAt = updatedAt
        }
        
        if let tagList = model.tagList, tagList.count > 0 {
            self.tagList = tagList
        }
    }

    init(_ model: Breweries) {
        self.id = Int(model.id)
        self.name = model.name
        
        if let street = model.street, street.hasChars() {
            self.street = street
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let city = model.city, city.hasChars() {
            self.city = city
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let state = model.state, state.hasChars() {
            self.state = state
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let country = model.country, country.hasChars() {
            self.country = country
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let longitude = model.longitude, longitude.hasChars() {
            self.longitude = longitude
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let latitude = model.latitude, latitude.hasChars() {
            self.latitude = latitude
        }
        
        if let phone = model.phone, phone.hasChars() {
            self.phone = phone
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
        
        if let websiteUrl = model.webSite, websiteUrl.hasChars() {
            self.websiteUrl = websiteUrl
        } else {
            self.breweryHeight -= self.stackViewLabelHeight
        }
    }
}

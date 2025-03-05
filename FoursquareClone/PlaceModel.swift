//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Murat Alarcin on 4.03.2025.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var choosenLatitude = ""
    var choosenLongitude = ""
    
    private init() {}
    
}


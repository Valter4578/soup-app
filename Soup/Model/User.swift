//
//  User.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import Foundation
import CoreLocation

struct SoupUser: Identifiable, Codable {
    let id: String
    var email: String
    var name: String
    var partnerId: String?
    var location: Location
    
//    var status: String
//    var nextMeeting: String?
    
    struct Location: Codable {
        var latitude: Double
        var longitude: Double
    }
}

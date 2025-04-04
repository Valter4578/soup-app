//
//  FirebaseDatabaseService.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import FirebaseAuth
import FirebaseDatabase
import CoreLocation
import SwiftUI

// Protocol that any database service must implement
protocol DatabaseServiceProtocol {
    // Partner management
    func setPartner(partnerId: String, completion: @escaping (Error?) -> Void)
    func getPartner(completion: @escaping (String?, Error?) -> Void)
    
    // Location management
    func updateLocation(location: CLLocation, completion: @escaping (Error?) -> Void)
    func getLocation(forUser userId: String, completion: @escaping (CLLocation?, Error?) -> Void)
    
    // Feeling management
    func updateFeeling(feeling: Feeling, completion: @escaping (Error?) -> Void)
    func getLastFeeling(completion: @escaping (Feeling?, Error?) -> Void)
    func getLastFeeling(forUser userId: String, completion: @escaping (Feeling?, Error?) -> Void)
    func listenToPartnerFeeling(partnerId: String, onChange: @escaping (Feeling?) -> Void) -> DatabaseHandle? 
}

@Observable
class FirebaseDatabaseService: DatabaseServiceProtocol {
    
    @ObservationIgnored
    private lazy var userPath: DatabaseReference? = {
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        
        let ref = Database.database()
            .reference()
            .child("users/\(uid)")
        return ref
    }()
    
    @ObservationIgnored
    private lazy var defaultPath: DatabaseReference? = {
        Database.database().reference()
    }()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - Partner Management
    func setPartner(partnerId: String, completion: @escaping (Error?) -> Void) {
        guard let userPath = userPath else {
            completion(NSError(domain: "FirebaseService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        userPath.child("partnerId").setValue(partnerId) { error, _ in
            completion(error)
        }
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "FirebaseService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        defaultPath?.child("users/\(partnerId)").child("partnerId").setValue(currentUserId) { error, _ in
            completion(error)
        }
    }

    func getPartner(completion: @escaping (String?, Error?) -> Void) {
        guard let userPath = userPath else {
            completion(nil, NSError(domain: "FirebaseService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        userPath.child("partnerId").observeSingleEvent(of: .value) { snapshot, _ in
            if let partnerId = snapshot.value as? String {
                completion(partnerId, nil)
            } else {
                completion(nil, nil) // No partner set yet
            }
        }
    }
    
    // MARK: - Location Management
    func updateLocation(location: CLLocation, completion: @escaping (Error?) -> Void) {
        guard let userPath = userPath else {
            completion(NSError(domain: "FirebaseService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        let locationData: [String: Any] = [
            "latitude": location.coordinate.latitude,
            "longitude": location.coordinate.longitude,
            "timestamp": ServerValue.timestamp()
        ]
        
        userPath.child("location").setValue(locationData) { error, _ in
            completion(error)
        }
    }
    
    func getLocation(forUser userId: String, completion: @escaping (CLLocation?, Error?) -> Void) {
        let userRef = Database.database().reference().child("users/\(userId)/location")
        
        userRef.observeSingleEvent(of: .value) { snapshot, _ in
            guard let locationData = snapshot.value as? [String: Any],
                  let latitude = locationData["latitude"] as? Double,
                  let longitude = locationData["longitude"] as? Double else {
                completion(nil, nil) // No location data yet
                return
            }
            
            let location = CLLocation(latitude: latitude, longitude: longitude)
            completion(location, nil)
        }
    }
    
    // MARK: - Feeling Management
    func updateFeeling(feeling: Feeling, completion: @escaping (Error?) -> Void) {
        guard let userPath = userPath else {
            completion(NSError(domain: "FirebaseService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        // Need to convert Color to a storable format (e.g., hex string)
        do {
            let feelingData: [String: Any] = [
                "name": feeling.name,
                "emojiText": feeling.emojiText,
                "colorName": feeling.color.hex,
                "timestamp": ServerValue.timestamp()
            ]
            
            userPath.child("lastFeeling").setValue(feelingData) { error, _ in
                completion(error)
            }
        }
    }
    
    func getLastFeeling(completion: @escaping (Feeling?, Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "FirebaseService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        getLastFeeling(forUser: uid, completion: completion)
    }
    
    func getLastFeeling(forUser userId: String, completion: @escaping (Feeling?, Error?) -> Void) {
        let userRef = Database.database().reference().child("users/\(userId)/lastFeeling")
        
        userRef.observeSingleEvent(of: .value) { snapshot, _ in
            guard let feelingData = snapshot.value as? [String: Any],
                  let name = feelingData["name"] as? String,
                  let emojiText = feelingData["emojiText"] as? String,
                  let colorHex = feelingData["colorName"] as? String else {
                completion(nil, nil) // No feeling data yet
                return
            }
            
            // Convert hex back to Color
            let color = Color(hex: colorHex) ?? .black
            let feeling = Feeling(name: name, emojiText: emojiText, color: color)
            completion(feeling, nil)
        }
    }
    
    // MARK: - Real-time Listeners
    
    // Example function to listen for partner's feeling changes
    func listenToPartnerFeeling(partnerId: String, onChange: @escaping (Feeling?) -> Void) -> DatabaseHandle? {
        let partnerRef = Database.database().reference().child("users/\(partnerId)/lastFeeling")
        
        return partnerRef.observe(.value) { snapshot in
            guard let feelingData = snapshot.value as? [String: Any],
                  let name = feelingData["name"] as? String,
                  let emojiText = feelingData["emojiText"] as? String,
                  let colorHex = feelingData["colorName"] as? String else {
                onChange(nil)
                return
            }
            
            let color = Color(hex: colorHex) ?? .black
            let feeling = Feeling(name: name, emojiText: emojiText, color: color)
            onChange(feeling)
        }
    }
    
    // Function to remove a listener
    func removeListener(handle: DatabaseHandle, forPath path: String) {
        Database.database().reference().child(path).removeObserver(withHandle: handle)
    }
}

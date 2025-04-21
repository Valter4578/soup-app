//
//  FeelingResponse.swift
//  Soup
//
//  Created by Максим Алексеев  on 20.04.2025.
//

import Foundation

struct FeelingResponse: Identifiable {
    let id: UUID
    let feeling: Feeling
    /// seconds from 1970 
    let timestamp: Int
//    let audioData: Data?
//    let photoData: Data?
}

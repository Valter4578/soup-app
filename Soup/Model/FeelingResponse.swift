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
    let timestamp: String
//    let audioData: Data?
//    let photoData: Data?
}

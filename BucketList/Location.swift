//
//  Location.swift
//  BucketList
//
//  Created by murad on 20.09.2026.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}

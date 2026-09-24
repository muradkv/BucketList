//
//  Result.swift
//  BucketList
//
//  Created by murad on 24.09.2026.
//

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}

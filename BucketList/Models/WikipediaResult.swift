//
//  WikipediaResult.swift
//  BucketList
//
//  Created by murad on 24.09.2026.
//

struct WikipediaResult: Codable {
    let query: WikipediaQuery
}

struct WikipediaQuery: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}

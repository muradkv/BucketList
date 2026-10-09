//
//  NearbyPlaceRowView.swift
//  BucketList
//
//  Created by murad on 08.10.2026.
//

import SwiftUI

struct NearbyPlaceRowView: View {
    let page: Page
    
    var body: some View {
        Text(page.title)
            .font(.headline)
        + Text(": ") +
        Text(page.description)
            .italic()
    }
}

#Preview {
    NearbyPlaceRowView(page: Page(pageid: 1, title: "Page title", terms: nil))
}

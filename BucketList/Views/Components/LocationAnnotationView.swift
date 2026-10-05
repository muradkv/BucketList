//
//  LocationAnnotationView.swift
//  BucketList
//
//  Created by murad on 05.10.2026.
//

import SwiftUI

struct LocationAnnotationView: View {
    var onSelect: () -> Void
    
    var body: some View {
        Image(systemName: "star.circle")
            .resizable()
            .foregroundStyle(.red)
            .frame(width: 44, height: 44)
            .background(.white)
            .clipShape(.circle)
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.5)
                    .onEnded { _ in
                        onSelect()
                    }
            )
    }
}

#Preview {
    LocationAnnotationView() { }
}

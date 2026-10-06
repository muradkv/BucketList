//
//  MapStylePickerView.swift
//  BucketList
//
//  Created by murad on 06.10.2026.
//

import SwiftUI

struct MapStylePickerView: View {
    @Binding var isHybrid: Bool
    
    var body: some View {
        Picker("Map Style", selection: $isHybrid) {
            Text("Standard").tag(false)
            Text("Hybrid").tag(true)
        }
        .pickerStyle(.segmented)
        .padding(8)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 12))
        .padding(.horizontal)
    }
}

#Preview {
    MapStylePickerView(isHybrid: .constant(true))
}

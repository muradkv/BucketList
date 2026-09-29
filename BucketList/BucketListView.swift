//
//  ContentView.swift
//  BucketList
//
//  Created by murad on 19.09.2026.
//

import SwiftUI
import MapKit

struct BucketListView: View {
    @State private var viewModel = ViewModel()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .simultaneousGesture(
                                    LongPressGesture(minimumDuration: 0.5)
                                        .onEnded { _ in
                                            viewModel.selectedPlace = location
                                        }
                                )
                        }
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) {
                        viewModel.update(location: $0)
                    }
                }
                .mapStyle(viewModel.isHybrid ? .hybrid : .standard)
                .safeAreaInset(edge: .bottom) {
                    Picker("Map Style", selection: Binding(
                        get: { viewModel.isHybrid },
                        set: { viewModel.setMapStyle(isHybrid: $0)}
                    )) {
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
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    BucketListView()
}

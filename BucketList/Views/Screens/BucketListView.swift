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
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: viewModel.startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            LocationAnnotationView {
                                viewModel.selectedPlace = location
                            }
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
                    MapStylePickerView(isHybrid: $viewModel.isHybrid)
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Authentication Failed", isPresented: $viewModel.isShowingAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(viewModel.errorMessage)
                }
        }
    }
}

#Preview {
    BucketListView()
}

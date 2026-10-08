//
//  EditViewModel.swift
//  BucketList
//
//  Created by murad on 29.09.2026.
//

import SwiftUI

extension EditView {
    @Observable
    @MainActor
    final class ViewModel {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var name: String
        var description: String
        
        private(set) var loadingState = LoadingState.loading
        private(set) var pages = [Page]()
        
        let location: Location
        
        private let service: WikipediaServiceProtocol
        
        init(location: Location, service: WikipediaServiceProtocol = WikipediaService() ) {
            self.location = location
            self.name = location.name
            self.description = location.description
            self.service = service
        }
        
        func fetchNearbyPlaces() async {
            loadingState = .loading
            
            do {
                pages = try await service.fetchNearbyPlaces(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
                loadingState = .loaded
            } catch {
                print("Failed to fetch nearby places: \(error.localizedDescription)")
                loadingState = .failed
            }
        }
        
        func makeUpdatedLocation() -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            return newLocation
        }
    }
}


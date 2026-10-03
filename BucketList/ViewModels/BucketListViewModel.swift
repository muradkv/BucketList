//
//  BucketListViewModel.swift
//  BucketList
//
//  Created by murad on 26.09.2026.
//

import SwiftUI
import MapKit
import LocalAuthentication

extension BucketListView {
    @Observable
    @MainActor
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        var isUnlocked = false
        private(set) var isHybrid = false
        
        var isShowingAlert = false
        private(set) var errorMessage = ""
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func setMapStyle(isHybrid: Bool) {
            self.isHybrid = isHybrid
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        private func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func authenticate() {
#if targetEnvironment(simulator)
            isUnlocked = true
#else
            
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    Task { @MainActor in
                        if success {
                            self.isUnlocked = true
                        } else {
                            self.errorMessage = authenticationError?.localizedDescription ?? "Failed to authenticate. Please try again."
                            self.isShowingAlert = true
                        }
                    }
                }
            } else {
                self.errorMessage = "Biometric authentication is unavailable. Please make sure Face ID or Touch ID is enabled in your device settings."
                self.isShowingAlert = true
            }
#endif
        }
    }
}

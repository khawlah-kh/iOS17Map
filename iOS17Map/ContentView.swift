//
//  ContentView.swift
//  iOS17Map
//
//  Created by Khawlah Khalid on 23/11/2023.
//

import SwiftUI
import MapKit

let coordinates = CLLocationCoordinate2D(latitude: 37.334967, longitude:  -121.892566)

struct ContentView: View {
    @State var cameraPosition: MapCameraPosition = .region(.init(center: coordinates, latitudinalMeters: 1200, longitudinalMeters: 1200))
    
    @State var lookAroundScene: MKLookAroundScene?{
        didSet{
            if let _ = lookAroundScene{
                isShowingLookAroundScene = true
            }
        }
    }
    
    @State var isShowingLookAroundScene: Bool = false
    
    var body: some View {
        Map(initialPosition: cameraPosition){
            Annotation("Some location", coordinate: coordinates) {
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundStyle(.pink.gradient)
                    .onTapGesture {
                        getLookAroundScene(for: coordinates)
                    }
            }
        }
        .lookAroundViewer(isPresented: $isShowingLookAroundScene,
                          scene: $lookAroundScene)
        
        
    }
    
    func getLookAroundScene(for location: CLLocationCoordinate2D){
        Task{
            let request = MKLookAroundSceneRequest(coordinate: location)
            lookAroundScene = try? await request.scene
        }
    }
}

#Preview {
    ContentView()
}

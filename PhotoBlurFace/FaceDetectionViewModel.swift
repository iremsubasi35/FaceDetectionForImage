//
//  FaceDetectionViewModel.swift
//  PhotoBlurFace
//
//  Created by İrem Subaşı on 11.03.2024.
//

import Combine
import UIKit
import Vision

class FaceDetectionViewModel: ObservableObject {
    @Published var detectedFaces: [CGRect] = []
    
    func detectFacesInImage() {
        guard let image = UIImage(named: "oscarSelfie"),
              let cgImage = image.cgImage else {
            print("Failed to load image.")
            return
        }
        
        let faceDetectionRequest = VNDetectFaceRectanglesRequest { request, error in
            guard let results = request.results as? [VNFaceObservation] else { return }
            DispatchQueue.main.async {
                self.detectedFaces = results.map { $0.boundingBox }
            }
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        do {
            try handler.perform([faceDetectionRequest])
        } catch {
            print("Failed to perform face detection: \(error)")
        }
    }
}

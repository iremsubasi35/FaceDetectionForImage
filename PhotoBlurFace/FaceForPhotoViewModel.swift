//
//  FaceForPhotoViewModel.swift
//  PhotoBlurFace
//
//  Created by İrem Subaşı on 10.03.2024.
//

import Foundation
import Combine
import Vision
import UIKit

final class FaceForPhotoViewModel:ObservableObject {
    @Published var detectedFaces: [VNFaceObservation] = []
    @Published var frames: [CGRect] = []
    @Published var imageSize: CGSize = .zero
    let image: UIImage = UIImage(named:"OscarSelfie")!
    
    func initialize() {
        let width = UIScreen.main.bounds.size.width
        let height = width * (image.size.height / image.size.width)
        self.imageSize = CGSize(width: width, height: height)
    }
    
    func detectFaces(in image: UIImage) {
            guard let cgImage = image.cgImage else { return }
            
            let request = VNDetectFaceRectanglesRequest { request, error in
                if let error = error {
                    print("Error detecting faces: \(error.localizedDescription)")
                    return
                }
                
                guard let observations = request.results as? [VNFaceObservation] else { return }
                
                DispatchQueue.main.async {
                    self.detectedFaces = observations
                    var arr: [CGRect] = []
                    for observation in observations {
                            let boundingBox = observation.boundingBox
                        print(boundingBox)
                        print(image.size)
                        let imageSize = self.imageSize
                        let minX = boundingBox.minX * imageSize.width
                        let minY = (1 - boundingBox.maxY) * imageSize.height
                        let width = boundingBox.width * imageSize.width
                        let height = boundingBox.height * imageSize.height
                        
                            let rect = CGRect(x: minX, y: minY, width: width, height: height)
                        arr.append(rect)
                            print("Face frame: CGRect(x: \(minX), y: \(minY), width: \(width), height: \(height))")
                        }
                    self.frames = arr
                }
            }
            
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try handler.perform([request])
            } catch {
                print("Error performing face detection: \(error.localizedDescription)")
            }
        }
}


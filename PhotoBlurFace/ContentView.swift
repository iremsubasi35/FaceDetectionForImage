//
//  ContentView.swift
//  PhotoBlurFace
//
//  Created by İrem Subaşı on 10.03.2024.
//

import SwiftUI
import Vision


struct ContentView: View {
    @ObservedObject  private var viewModel: FaceForPhotoViewModel
  //  @State private var image: UIImage? = nil
    init(viewModel:FaceForPhotoViewModel){
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            
            ZStack{
                Image("OscarSelfie")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: viewModel.imageSize.width, height: viewModel.imageSize.height)
                ForEach(viewModel.frames, id: \.self) { rect in
                    Rectangle()
                        .stroke(Color.red, lineWidth: 2)
                        .frame(width: rect.size.width, height: rect.size.height)
                        .offset(CGSize(width: rect.origin.x - viewModel.imageSize.width / 2 + rect.size.width / 2 , height: rect.origin.y - viewModel.imageSize.height / 2 + rect.size.height / 2))
                }
            }
                Button(action: {
                    viewModel.detectFaces(in: UIImage(named: "OscarSelfie")!)

                }) {
                    Text("Face Close")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            Text("Detected Faces: \(viewModel.detectedFaces.count)")
                            .padding()
        }
        .onAppear{
            viewModel.initialize()
        }
    }
//    func addRectToImage(on image: Image, imageSize: CGSize) -> some View {
//            let detectedFaces = viewModel.detectedFaces
//            return image
//                .resizable()
//                .overlay(
//                    GeometryReader { geo in
//                        ForEach(detectedFaces, id: \.self) { face in
//                            let boundingBox = face.boundingBox
//                            let scaleBox = CGRect(x: boundingBox.origin.x * imageSize.width,
//                                                  y: (1 - boundingBox.origin.y - boundingBox.size.height) * imageSize.height,
//                                                  width: boundingBox.size.width * imageSize.width,
//                                                  height: boundingBox.size.height * imageSize.height)
//
//                            Rectangle()
//                                .stroke(Color.red, lineWidth: 2)
//                                .frame(width: scaleBox.size.width, height: scaleBox.size.height)
//                                .offset(x: scaleBox.origin.x, y: scaleBox.origin.y)
//                        }
//                    }
//                )
//        }
}
extension CGRect: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(minX)
        hasher.combine(minY)
        hasher.combine(width)
        hasher.combine(height)
    }
}

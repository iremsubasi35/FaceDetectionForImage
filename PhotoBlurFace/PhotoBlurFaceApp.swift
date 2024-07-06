//
//  PhotoBlurFaceApp.swift
//  PhotoBlurFace
//
//  Created by İrem Subaşı on 10.03.2024.
//

import SwiftUI

@main
struct PhotoBlurFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: FaceForPhotoViewModel())
        }
    }
}

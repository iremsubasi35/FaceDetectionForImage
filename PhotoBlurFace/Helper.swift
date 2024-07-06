//
//  Helper.swift
//  PhotoBlurFace
//
//  Created by İrem Subaşı on 10.03.2024.
//

import UIKit

extension UIViewController{
    public func convertUnitToPoint(originalImageRect: CGRect, targetRect: CGRect) ->CGRect {
        var pointRect = targetRect
        pointRect.origin.x = originalImageRect.origin.x + (targetRect.origin.x * originalImageRect.size.width)
        pointRect.origin.y = originalImageRect.origin.y + (1-targetRect.origin.y - targetRect.height) * originalImageRect.size.height
        pointRect.size.width *= originalImageRect.size.width
        pointRect.size.height *= originalImageRect.size.height
        
        return pointRect
    }
    
    public func determineScale(cgImage:CGImage,imageViewFrame: CGRect) -> CGRect{
        let originalWidth = CGFloat(cgImage.width)
        let originalHeight = CGFloat(cgImage.height)
        
        let imageFrame = imageViewFrame
        let widthRatio = originalWidth/imageViewFrame.width
        let heightRatio = originalHeight/imageViewFrame.height
        
        let scaleRatio = max(widthRatio,heightRatio)
        
        let scaleImageWidth = originalWidth / scaleRatio
        let scaleImageHeight = originalHeight / scaleRatio
        
        let scaleImageX = (imageFrame.width - scaleImageWidth) / 2
        let scaleImageY = (imageFrame.height - scaleImageHeight) / 2
        
        return CGRect(x: scaleImageX, y: scaleImageY, width: scaleImageWidth, height: scaleImageHeight)
    }
}

extension CGImagePropertyOrientation {
    init(_ orientation: UIImage.Orientation){
        switch orientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        default: self = .up
        }
    }
}

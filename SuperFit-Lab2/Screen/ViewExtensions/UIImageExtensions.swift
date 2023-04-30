//
//  UIImageExtensions.swift
//  SuperFit-Lab2
//
//  Created by admin on 30.04.2023.
//

import UIKit

extension UIImage {
    func resizeImage(newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        let targetSize = CGSize(width: newWidth, height: newHeight)
        
        let widthScaleRatio = targetSize.width / self.size.width
        let heightScaleRatio = targetSize.height / self.size.height
        
        let scaleFactor = min(widthScaleRatio, heightScaleRatio)
        
        let scaledImageSize = CGSize(width: self.size.width * scaleFactor, height: self.size.height * scaleFactor)
        
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }
        return scaledImage
    }
}

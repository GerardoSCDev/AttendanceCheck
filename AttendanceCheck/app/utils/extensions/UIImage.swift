//
//  UIImage.swift
//  AttendanceCheck
//
//  Created by Gerardo Santillan Cruzado on 19/05/25.
//
import UIKit

extension UIImage {
    var squared: UIImage? {
        guard let cgImage = cgImage else { return nil }
        let length = min(cgImage.width, cgImage.height)
        let x = cgImage.width / 2 - length / 2
        let y = cgImage.height / 2 - length / 2
        let cropRect = CGRect(x: x, y: y, width: length, height: length)
        
        guard let croppedCGImage = cgImage.cropping(to: cropRect) else {  return nil }
        return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
    }
    
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

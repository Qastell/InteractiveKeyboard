//
// Created by max on 07.12.2017.
// Copyright (c) 2017 101 GROUP. All rights reserved.
//

import UIKit
import CoreGraphics
import Accelerate.vImage
import AVFoundation
import MobileCoreServices

enum HEICError: Error {
    case heicNotSupported
    case cgImageMissing
    case couldNotFinalize
}

extension CGSize {
    func aspectFit(to side: CGFloat) -> CGSize {
        let side2 = width > height ? ceil(side / width * height) : ceil(side / height * width)
        return CGSize(width: Int(width > height ? side : side2),
                      height: Int(width > height ? side2 : side))
    }

    func aspectFill(to side: CGFloat) -> CGSize {
        let side2 = width < height ? ceil(side / width * height) : ceil(side / height * width)
        return CGSize(width: Int(width < height ? side : side2),
                      height: Int(width < height ? side2 : side))
    }
}

public enum FileType {
    case jpg, heic, mp4

    var mimeType: String {
        switch self {
        case .mp4:
            return "video/mp4"
        case .heic:
            return "image/heic"
        case .jpg:
            return "image/jpeg"
        }
    }
}

public extension UIImage {
	convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
		let rect = CGRect(origin: .zero, size: size)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
		color.setFill()
		UIRectFill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		guard let cgImage = image?.cgImage else { return nil }
		self.init(cgImage: cgImage)
	}

    convenience init?(underscoreLineHeight: CGFloat, bounds: CGRect, color: UIColor) {
        let size = bounds.size
        let rect = CGRect(origin: .zero, size: size)
        let rectLine = CGRect(x: 0,
                              y: size.height - underscoreLineHeight,
                              width: size.width,
                              height: underscoreLineHeight)

        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        UIColor.grpWhite.setFill()
        UIRectFill(rect)
        color.setFill()
        UIRectFill(rectLine)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

//    static func preview(for videoUrl: URL) -> UIImage? {
//        do {
//            let asset = AVAsset(url: videoUrl)
//            let generator = AVAssetImageGenerator(asset: asset)
//            let side = Settings.shared.biggestPreviewSide
//            let size = CGSize(width: side, height: side)
//            generator.maximumSize = size
//            generator.appliesPreferredTrackTransform = true
//            let thumbnail = try generator.copyCGImage(at: .zero, actualTime: nil)
//            let image = UIImage(cgImage: thumbnail)
//
//            return UIGraphicsImageRenderer(size: size).image { context in
//                image.draw(in: CGRect(origin: .zero, size: size))
//                let view = UIView(frame: CGRect(x: 0, y: size.height - 40, width: size.width, height: 40))
//                view.backgroundColor = UIColor.grpBlack.withAlphaComponent(0.4)
//                context.cgContext.translateBy(x: view.frame.minX, y: view.frame.minY)
//                view.layer.render(in: context.cgContext)
//                context.cgContext.translateBy(x: -view.frame.minX, y: -view.frame.minY)
//                let font = UIFont.grpBold24
//                let textStyle = NSMutableParagraphStyle()
//                textStyle.alignment = .right
//                let duration = Int(CMTimeGetSeconds(asset.duration))
//                String(format:"%02d:%02d", duration / 60, duration % 60)
//                    .draw(in: CGRect(x: 0,
//                                     y: size.height - font.lineHeight - (40 - font.lineHeight) / 2,
//                                     width: size.width - 12,
//                                     height: 40),
//                          withAttributes: [.font: font,
//                                           .foregroundColor: UIColor.grpWhite,
//                                           .paragraphStyle: textStyle])
//            }
//        } catch { debugPrint(error) }
//        return nil
//    }

    func resizedAsPngData(toBiggestSide side: CGFloat) -> Data? {
        let start = CACurrentMediaTime()
        let resized = max(size.width, size.height) > side ? (resize(toBiggestSide: side, with: .coreImage) ?? self) : self
        debugPrint(String(format: "resizing: %.3f", CACurrentMediaTime() - start))
        let data = resized.pngData()
        return data
    }
    
    func resizedAsJpegData(toBiggestSide side: CGFloat) -> Data? {
        let start = CACurrentMediaTime()
        let resized = max(size.width, size.height) > side ? (resize(toBiggestSide: side, with: .coreImage) ?? self) : self
        debugPrint(String(format: "resizing: %.3f", CACurrentMediaTime() - start))
        let data = resized.jpegData(compressionQuality: 0.9)
        return data
    }

//    func resizedWithPreview() -> (data: Data, previewData: Data, fileType: FileType)? {
//        let side: CGFloat = Settings.shared.biggestPhotoSide
//        var start = CACurrentMediaTime()
//        let resized = max(size.width, size.height) > side ? (resize(toBiggestSide: side, with: .coreImage) ?? self) : self
//        debugPrint(String(format: "resizing: %.3f", CACurrentMediaTime() - start))
//        start = CACurrentMediaTime()
//        var data: Data?
//        var fileType: FileType!
//        do {
//            data = try resized.heicData(compressionQuality: 0.76)
//            fileType = data != nil ? .heic : .jpg
//        } catch {
//            data = resized.jpegData(compressionQuality: 0.9)
//            fileType = .jpg
//        }
//        debugPrint(String(format: "compression: %.3f", CACurrentMediaTime() - start))
//        start = CACurrentMediaTime()
//        guard let d = data,
//            let previewData = resized
//                .resize(toBiggestSide: Settings.shared.biggestPreviewSide, with: .uikit)?
//                .jpegData(compressionQuality: 0.9) else { return nil }
//        debugPrint(String(format: "preview resizing and compression: %.3f", CACurrentMediaTime() - start))
//        return (d, previewData, fileType)
//    }

    func heicData(compressionQuality q: CGFloat) throws -> Data {
        guard #available(iOS 11.0, *) else { throw HEICError.heicNotSupported }
        let data = NSMutableData()
        guard let dest = CGImageDestinationCreateWithData(data, AVFileType.heic as CFString, 1, nil)
                else { throw HEICError.heicNotSupported }
        guard let cgImage = cgImage else { throw HEICError.cgImageMissing }
        CGImageDestinationAddImage(dest, cgImage, [kCGImageDestinationLossyCompressionQuality: q] as NSDictionary)
        guard CGImageDestinationFinalize(dest) else { throw HEICError.couldNotFinalize }
        return data as Data
    }

    enum ResizeFramework {
        case uikit, coreImage
    }

    func resize(toBiggestSide side: CGFloat, with resizeFramework: ResizeFramework) -> UIImage? {
        switch resizeFramework {
        case .uikit: return resizedWithUIKit(toBiggestSide: side)
        case .coreImage: return resizedWithCoreImage(to: size.aspectFit(to: side))
        }
    }

    private func resizedWithCoreImage(to newSize: CGSize) -> UIImage? {
        guard let cgImage = cgImage, let filter = CIFilter(name: "CILanczosScaleTransform") else { return nil }

        let ciImage = CIImage(cgImage: cgImage)
        let scale = (Double)(newSize.width) / (Double)(ciImage.extent.size.width)

        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value:scale), forKey: kCIInputScaleKey)
        filter.setValue(1.0, forKey: kCIInputAspectRatioKey)
        guard let outputImage = filter.value(forKey: kCIOutputImageKey) as? CIImage else { return nil }
        let context = CIContext(options: [.useSoftwareRenderer: false])
        guard let resultCGImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: resultCGImage, scale: 1, orientation: imageOrientation)
    }

    private func resizedWithUIKit(toBiggestSide side: CGFloat) -> UIImage? {
        let newSize = size.aspectFit(to: side)
        UIGraphicsBeginImageContextWithOptions(newSize, true, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

/// can be done "heic", "heix", "hevc", "hevx"
enum ImageFormat {
    case png, jpg, gif, tiff, webp, heic, unknown
}

extension Data {
    var imageFormat: ImageFormat {
        switch first {
        case 0x89:
            return .png
        case 0xFF:
            return .jpg
        case 0x47:
            return .gif
        case 0x49, 0x4D:
            return .tiff
        case 0x52 where count >= 12:
            if let dataString = String(data: self[0...11], encoding: .ascii),
                dataString.hasPrefix("RIFF"),
                dataString.hasSuffix("WEBP") {
                return .webp
            }
        case 0x00 where count >= 12:
            if let dataString = String(data: self[8...11], encoding: .ascii),
                Set(["heic", "heix", "hevc", "hevx"]).contains(dataString) {
                /// OLD: "ftypheic", "ftypheix", "ftyphevc", "ftyphevx"
                return .heic
            }
        default: break
        }
        return .unknown
    }
}

extension UIImage {
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()

        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {

        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

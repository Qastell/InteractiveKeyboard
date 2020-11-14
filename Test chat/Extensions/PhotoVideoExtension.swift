//
//  PhotoVideoExtension.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 27/09/2019.
//  Copyright © 2019 Yuri Kudrinetskiy. All rights reserved.
//

import AVFoundation
import Photos

extension AVCaptureDevice {
    class func checkAuthorization(completion: @escaping (Bool) -> Void) {
        guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            })
            return
        }
        completion(true)
    }
}

extension PHPhotoLibrary {
    class func checkAuthorization(completion: @escaping (Bool) -> Void) {
        guard PHPhotoLibrary.authorizationStatus() == .authorized else {
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    completion(status == .authorized)
                }
            }
            return
        }
        completion(true)
    }
}

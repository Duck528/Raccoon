//
//  Permission.swift
//  Raccoon
//
//  Created by thekan on 04/11/2018.
//  Copyright © 2018 thekan. All rights reserved.
//

import Photos
import RxSwift

struct Permission {
    
    enum Errors: Error {
        case notDetermined, denied, restricted
    }
    
    fileprivate static func checkCameraAccess(_ status: AVAuthorizationStatus) -> Observable<Void> {
        switch status {
        case .authorized:
            return .just(())
        case .notDetermined:
            /* 아직 지정 안됐을때 요청 */
            return .create { observer in
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { isAuthorized in
                    if isAuthorized {
                        observer.onNext(())
                        observer.onCompleted()
                    } else {
                        observer.onError(Errors.denied)
                    }
                })
                return Disposables.create()
            }
        case .denied:
            return .error(Errors.denied)
        case .restricted:
            return .error(Errors.restricted)
        }
    }
    
    fileprivate static func checkLibraryAccess(_ status: PHAuthorizationStatus) -> Observable<Void> {
        switch status {
        case .authorized:
            return .just(())
        case .notDetermined:
            /* 아직 지정 안됐을때 요청 */
            return .create { observer in
                PHPhotoLibrary.requestAuthorization({ requestedStatus in
                    switch requestedStatus {
                    case .authorized:
                        observer.onNext(())
                        observer.onCompleted()
                    case .notDetermined:
                        observer.onError(Errors.notDetermined)
                    case .denied:
                        observer.onError(Errors.denied)
                    case .restricted:
                        observer.onError(Errors.restricted)
                    }
                })
                return Disposables.create()
            }
        case .denied:
            return .error(Errors.denied)
        case .restricted:
            return .error(Errors.restricted)
        }
    }
    
    static func check(with sourceType: UIImagePickerController.SourceType) -> Observable<Void> {
        switch sourceType {
        case .camera:
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            return checkCameraAccess(status)
            
        case .photoLibrary, .savedPhotosAlbum:
            let status = PHPhotoLibrary.authorizationStatus()
            return checkLibraryAccess(status)
        }
    }
}

extension Permission.Errors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notDetermined:
            return "Permission not determined"
        case .denied:
            return "Permission denied"
        case .restricted:
            return "Permission restricted"
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .notDetermined:
            return "Permission not determined"
        case .denied:
            return "Permission denied"
        case .restricted:
            return "Permission restricted"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .notDetermined, .denied, .restricted:
            return "Turn on permission switch in the Settings app"
        }
    }
}

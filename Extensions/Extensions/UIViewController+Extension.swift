//
//  Extension+UIViewController.swift
//
//  Created by Yash Thaker on 26/11/18.
//  Copyright © 2018 Yash Thaker. All rights reserved.
//

import UIKit
import AVKit
import Photos

extension UIViewController {
    
    func addNotificationObserver(_ name: String, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    func removeNotificationObserver(_ name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addKeyboardWillShowNotification() {
        self.addNotificationObserver(UIResponder.keyboardWillShowNotification.rawValue, selector: #selector(UIViewController.keyboardWillShowNotification(_:)))
    }
    
    func addKeyboardDidShowNotification() {
        self.addNotificationObserver(UIResponder.keyboardDidShowNotification.rawValue, selector: #selector(UIViewController.keyboardDidShowNotification(_:)))
    }
    
    func addKeyboardWillHideNotification() {
        self.addNotificationObserver(UIResponder.keyboardWillHideNotification.rawValue, selector: #selector(UIViewController.keyboardWillHideNotification(_:)))
    }
    
    func addKeyboardDidHideNotification() {
        self.addNotificationObserver(UIResponder.keyboardDidHideNotification.rawValue, selector: #selector(UIViewController.keyboardDidHideNotification(_:)))
    }
    
    func removeKeyboardWillShowNotification() {
        self.removeNotificationObserver(UIResponder.keyboardWillShowNotification.rawValue)
    }
    
    func removeKeyboardDidShowNotification() {
        self.removeNotificationObserver(UIResponder.keyboardDidShowNotification.rawValue)
    }
    
    func removeKeyboardWillHideNotification() {
        self.removeNotificationObserver(UIResponder.keyboardWillHideNotification.rawValue)
    }
    
    func removeKeyboardDidHideNotification() {
        self.removeNotificationObserver(UIResponder.keyboardDidHideNotification.rawValue)
    }
    
    @objc open func keyboardDidShowNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardDidShowWithFrame(frame)
        }
    }
    
    @objc open func keyboardWillShowNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardWillShowWithFrame(frame)
        }
    }
    
    @objc func keyboardWillHideNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardWillHideWithFrame(frame)
        }
    }
    
    @objc func keyboardDidHideNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardDidHideWithFrame(frame)
        }
    }
    
    func keyboardWillShowWithFrame(_ frame: CGRect) {
        
    }
    
    func keyboardDidShowWithFrame(_ frame: CGRect) {
        
    }
    
    func keyboardWillHideWithFrame(_ frame: CGRect) {
        
    }
    
    func keyboardDidHideWithFrame(_ frame: CGRect) {
        
    }
    
}

extension UIViewController {
    
    open func presentVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func popToRootVC() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func dismissVC(completion: (() -> Void)? ) {
        dismiss(animated: true, completion: completion)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addAsChildViewController(_ vc: UIViewController, toView: UIView) {
        self.addChild(vc)
        toView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func setBackgroundImage(_ image: UIImage) {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
    
    func runAfter(_ seconds: Double = 0, completion: @escaping () -> ()) {
        if seconds == 0 { DispatchQueue.main.async { completion() } }
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: { completion() })
    }
    
    func showAlert(title: String? = nil, message: String? = nil, okHandler: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            if let okHandler = okHandler { okHandler() }
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    func createUniqueVideoUrlInDD() -> URL {
        return createUrlInAppDD(UUID().uuidString + ".MOV")
    }
    
    func createUniqueVideoUrlInTemp() -> URL {
        return createUrlInTemp(UUID().uuidString + ".MOV")
    }
    
    func createUrlInTemp(_ nameWithFileExtension: String) -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(nameWithFileExtension)
    }
    
    func createUrlInAppDD(_ nameWithFileExtension: String) -> URL {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentDirectory!.appendingPathComponent(nameWithFileExtension)
    }
    
    func removeFileIfExists(fileURL: URL) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(at: fileURL)
            } catch {
                print("Could not delete exist file so cannot write to it")
            }
        }
    }
    
    public static func clearTempFolder() {
        let fileManager = FileManager.default
        let tempFolderPath = NSTemporaryDirectory()
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: tempFolderPath + filePath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    func secureCopyItem(at srcUrl: URL, to dstUrl: URL) -> (isSuccess: Bool,error: Error?) {
        do {
            if FileManager.default.fileExists(atPath: dstUrl.path) {
                try FileManager.default.removeItem(at: dstUrl)
            }
            try FileManager.default.copyItem(at: srcUrl, to: dstUrl)
        } catch (let error) {
            print("Cannot copy item at \(srcUrl) to \(dstUrl): \(error)")
            return (false,error)
        }
        return (true, nil)
    }
    
    func askedCameraPermission(successHandler: @escaping () -> Void) {
        switch  AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            DispatchQueue.main.async { successHandler() }
        case .denied, .restricted:
            DispatchQueue.main.async { self.openSettingsForCameraPermission() }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async { successHandler() }
                    return
                }
                DispatchQueue.main.async { self.openSettingsForCameraPermission() }
            }
        }
    }
    
    func openSettingsForCameraPermission() {
        openSettingsForPermission(title: "App name", message: "This App doesn't have permission to use the camera, please change privacy settings")
    }
    
    func askedMicrophonePermission(successHandler: @escaping () -> Void) {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            DispatchQueue.main.async { successHandler() }
        case .denied:
            DispatchQueue.main.async { self.openSettingsForMicrophonePermission() }
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                if granted {
                    DispatchQueue.main.async { successHandler() }
                    return
                }
                DispatchQueue.main.async { self.openSettingsForMicrophonePermission() }
            })
        }
    }
    
    func openSettingsForMicrophonePermission() {
        openSettingsForPermission(title: "App name", message: "This App doesn't have permission to use the microphone, please change privacy settings")
    }
    
    func askedPhotoUsagePermission(successHandler: @escaping () -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                DispatchQueue.main.async { successHandler() }
            case .denied, .restricted:
                DispatchQueue.main.async { self.openSettingsForPhotoPermission() }
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    if newStatus == .authorized {
                        DispatchQueue.main.async { successHandler() }
                        return
                    }
                    DispatchQueue.main.async { self.openSettingsForPhotoPermission() }
                })
            }
        }
    }
    
    func openSettingsForPhotoPermission() {
        openSettingsForPermission(title: "App name", message: "This App doesn't have permission to use the photos, please change privacy settings")
    }
    
    private func openSettingsForPermission(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alertAction) in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func playVideo(_ videoUrl: URL) {
        let player = AVPlayer(url: videoUrl)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        self.present(playerVC, animated: true) {
            playerVC.player?.play()
        }
    }
    
}


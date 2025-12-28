//
//  CameraManager.swift
//  CameraManager
//
//  Created by Christian Quicano on 2/24/16.
//  Copyright © 2016 ecorenetworks. All rights reserved.
//

import UIKit

public final class CQZCameraManager: NSObject {
    
    // MARK: - Singleton
    public static let shared = CQZCameraManager()
    
    
    //MARK: - opens properties
    public var hasCamera: Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    public var allowsEditing: Bool {
        get { imagePickerController.allowsEditing }
        set { imagePickerController.allowsEditing = newValue }
    }
    
    // MARK: - Private properties
    private let imagePickerController = UIImagePickerController()
    private var didFinishPickingImage: ((UIImage?) -> Void)?
    
    // MARK: - Initializer
    private override init() {
        super.init()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
    }
    
    
    //MARK: - open methods
    public func showCameraFrontal(
        on viewController: UIViewController,
        completion: @escaping (UIImage?) -> Void
    ) {
        guard hasCamera else {
            completion(nil)
            return
        }
        
        imagePickerController.sourceType = .camera
        imagePickerController.cameraDevice = .front
        imagePickerController.showsCameraControls = true
        imagePickerController.allowsEditing = true
        
        didFinishPickingImage = completion
        viewController.present(imagePickerController, animated: true)
    }
    
    public func showActionSheetSelectImage(
        in viewController: UIViewController,
        allowsEditing: Bool,
        showCameraFrontal: Bool,
        titleAlert: String?,
        titleSourceCamera: String?,
        titleSourceLibrary: String?,
        completion: @escaping (UIImage?) -> Void,
        moreActions: [UIAlertAction]? = nil
    ) {
        self.allowsEditing = allowsEditing
        didFinishPickingImage = completion
        
        let alert = UIAlertController(
            title: titleAlert,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(
                title: titleSourceCamera ?? "Camera",
                style: .default
            ) { [weak self] _ in
                self?.takePhoto(in: viewController, useFrontCamera: showCameraFrontal)
            }
            alert.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let libraryAction = UIAlertAction(
                title: titleSourceLibrary ?? "Photo Library",
                style: .default
            ) { [weak self] _ in
                self?.selectPhoto(in: viewController)
            }
            alert.addAction(libraryAction)
        }
        
        moreActions?.forEach { alert.addAction($0) }
        
        alert.addAction(
            UIAlertAction(title: "Cancelar", style: .cancel)
        )
        
        viewController.present(alert, animated: true)
    }
    
    //MARK: - private methods
    private func takePhoto(
        in viewController: UIViewController,
        useFrontCamera: Bool
    ) {
        imagePickerController.sourceType = .camera
        imagePickerController.showsCameraControls = true
        imagePickerController.cameraDevice = useFrontCamera ? .front : .rear
        viewController.present(imagePickerController, animated: true)
    }
    
    private func selectPhoto(in viewController: UIViewController) {
        imagePickerController.sourceType = .photoLibrary
        viewController.present(imagePickerController, animated: true)
    }
    
    private func finishPicking(image: UIImage?) {
        imagePickerController.dismiss(animated: true)
        didFinishPickingImage?(image)
        didFinishPickingImage = nil
    }
}

extension CQZCameraManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let image =
        (info[.editedImage] ?? info[.originalImage]) as? UIImage
        finishPicking(image: image)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        finishPicking(image: nil)
    }
}

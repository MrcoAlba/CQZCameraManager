//
//  ViewController.swift
//  CameraApplication
//
//  Created by Christian Quicano on 2/24/16.
//  Copyright © 2016 ecorenetworks. All rights reserved.
//

import UIKit
import CQZCameraManager

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showActionSheetCamera(_ sender: UIButton) {
        CQZCameraManager.shared.showActionSheetSelectImage(
            in: self,
            allowsEditing: false,
            showCameraFrontal: true,
            titleAlert: nil,
            titleSourceCamera: "Take Picture",
            titleSourceLibrary: "Select Picture",
            completion: { image in
                if image != nil {
                    print("Image selected")
                } else {
                    print("Selection cancelled")
                }
            },
            moreActions: nil
        )
    }
    
    @IBAction func changeAllowsEditing(_ sender: UISwitch) {
        CQZCameraManager.shared.allowsEditing = sender.isOn
    }
}

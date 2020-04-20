//
//  ViewController.swift
//  MemeMe-1.0
//
//  Created by Enemona Okeme on 18/04/2020.
//  Copyright © 2020 shamnex. All rights reserved.
//

import UIKit

class ViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var memeImageOutlet: UIImageView!
    
    @IBOutlet weak var camerButton: UIBarButtonItem!
    @IBOutlet weak var galleryButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let topTextFieldDelegate = MemeTextFieldDelegate(intialText: "TOP")
    let bottomTextFieldDelegate = MemeTextFieldDelegate(intialText: "BOTTOM")

    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.darkGray,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "AvenirNextCondensed-Heavy", size: 40)!,
        NSAttributedString.Key.strokeWidth: -5,
    ]
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        camerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        prepareView()
        super.viewDidLoad()
    }
    
    
    func prepareView () {
        configureTextField(intialText: "TOP", textField: topTextField)
        configureTextField(intialText: "BOTTOM", textField: bottomTextField)

    }
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillShow(_ notification:Notification) {

        if bottomTextField.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
     }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func configureTextField(intialText: String,  textField: UITextField)  {
        
           textField.defaultTextAttributes = memeTextAttributes
           textField.textAlignment = .center
           textField.text  = intialText
           textField.borderStyle = .none
        
            if intialText == "TOP" {
                 textField.delegate = topTextFieldDelegate
            } else {
                textField.delegate = bottomTextFieldDelegate

            }

    }
    

    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if sender.title! == "CameraButton" {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

         memeImageOutlet.image = info[.originalImage] as? UIImage
         dismiss(animated: true)
     }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true)
    }
     
    
}


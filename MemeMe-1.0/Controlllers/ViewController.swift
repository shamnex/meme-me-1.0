//
//  ViewController.swift
//  MemeMe-1.0
//
//  Created by Enemona Okeme on 18/04/2020.
//  Copyright © 2020 shamnex. All rights reserved.
//

import UIKit

class ViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - IBOUTLETS

    @IBOutlet weak var memeImageOutlet: UIImageView!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    
    @IBOutlet weak var camerButton: UIBarButtonItem!
    @IBOutlet weak var galleryButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    // MARK: - LOCAL VARIABLS

    
    let topTextFieldDelegate = MemeTextFieldDelegate(intialText: "TOP")
    
    let bottomTextFieldDelegate = MemeTextFieldDelegate(intialText: "BOTTOM")
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.darkGray,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "AvenirNextCondensed-Heavy", size: 40)!,
        NSAttributedString.Key.strokeWidth: -5,
    ]
    
    // MARK: - LIFE CYCLE HOOKS

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        camerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
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
    
    
   
    
    // MARK: - KEYBOARD NOTIFICATIONS
    
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
    
    // MARK: - TEXTFIELDS
    
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
    
    // MARK: - IBACTIONS
    
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if sender.title! == "CameraButton" {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
         let meme = generateMemedImage()
         let activityController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
         
         activityController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
         Bool, arrayReturnedItems: [Any]?, error: Error?) in
             if completed {
                 self.save();
                 return
             } else {
                 print("cancel")
             }
             if let shareError = error {
                 print("error while sharing: \(shareError.localizedDescription)")
             }
         }
         
         present(activityController, animated: true, completion: nil)

     }
     
     @IBAction func clearButton(_ sender: Any) {
         memeImageOutlet.image = nil
         topTextField.text = topTextFieldDelegate.intialtext
         bottomTextField.text = bottomTextFieldDelegate.intialtext
         
     }
    
    
    // MARK: - IMAGE PICKER

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
         shareButton.isEnabled = true
         memeImageOutlet.image = info[.originalImage] as? UIImage
         dismiss(animated: true)
     }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if memeImageOutlet.image != nil {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
         dismiss(animated: true)
    }
    
    
    func prepareView () {
           configureTextField(intialText: "TOP", textField: topTextField)
           configureTextField(intialText: "BOTTOM", textField: bottomTextField)

    }
    
    
    func save() {
        _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeImageOutlet.image!, memedImage: generateMemedImage())
    }
    
    func generateMemedImage() -> UIImage {
        
        toolBar.isHidden = true
        navBar.isHidden = true
        if  bottomTextField.text! == "BOTTOM" {
            bottomTextField.isHidden = true
        }

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //show toolbar
        toolBar.isHidden = false
        navBar.isHidden = false
        bottomTextField.isHidden = false

        return memedImage
    }
     
 
}


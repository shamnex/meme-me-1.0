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
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.darkGray,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 36)!,
        NSAttributedString.Key.strokeWidth: 10
    ]
    
    override func viewDidLoad() {
        prepareView()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        camerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func prepareView () {
        configureTextField(intialText: "TOP", textField: topTextField)
    }
    
    func configureTextField(intialText: String,  textField: UITextField)  {
        
           textField.defaultTextAttributes = memeTextAttributes
           textField.textAlignment = .center
           textField.text  = intialText
           textField.borderStyle = .none
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


//
//  MemeTextFieldDelegate.swift
//  MemeMe-1.0
//
//  Created by Enemona Okeme on 20/04/2020.
//  Copyright © 2020 shamnex. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    let _intialtext: String

    
    init(intialText: String) {
         self._intialtext = intialText
     }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if  textField.text  == _intialtext {
            textField.text = ""
        }
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let textFieldvalue = textField.text {
            if textFieldvalue.isEmpty {
                textField.text = _intialtext
            }
        }
       
    }
}


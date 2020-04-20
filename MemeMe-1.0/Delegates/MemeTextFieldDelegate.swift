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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

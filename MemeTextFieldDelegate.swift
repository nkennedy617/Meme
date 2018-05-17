//
//  MemeTextFieldDelegate.swift
//  TextFields
//
//  Created by Jason on 11/11/14.
//  Copyright (c) 2014 Udacity. All rights reserved.
//

import Foundation
import UIKit

// MARK: - MemeTextFieldDelegate : NSObject, UITextFieldDelegate

class MemeTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    // MARK: Properties
    
    var translations = [String : String]()
    
    // MARK: Initializer
    
    override init() {
        super.init()
        
        
    }
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if((textField.text == "TOP") || (textField.text == "BOTTOM")){
           textField.text = ""
        }
    }
}

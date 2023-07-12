//
//  OTPField + UITextFieldDelegete.swift
//  OTP
//
//  Created by sismac020 on 26/06/23.
//

import Foundation
import UIKit

extension OTPField :UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let charactersCount = textField.text?.count else {return false}
        return charactersCount < digitsLabels.count || string == ""
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        editingStatus?(.Begain)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        editingStatus?(.Ended)
    }
}

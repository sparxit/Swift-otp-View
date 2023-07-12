//
//  OTPStackView.swift
//  OTP
//
//  Created by sismac020 on 05/07/23.
//

import Foundation
import UIKit

protocol OTPDelegate: AnyObject {
    //always triggers when the OTP field is valid
    func didChangeValidity(isValid: Bool)
}

class OTPStackView: UIStackView {
    
    //Customise the OTPField here
    var numberOfFields = 6
    var showsWarningColor = false
    var borderWidth = 2
    var tfCornerRadius = 5
    var tfSpacing = 5
    var textFont = UIFont(name: "Kefa", size: 40)
    var remainingStrStack: [String] = []
    var textFieldsCollection: [OTPTextField] = []
    weak var delegate: OTPDelegate?
    
    //Colors
    var inactiveFieldBorderColor = UIColor.gray
    var textBackgroundColor = UIColor.black
    var textColor = UIColor.white
    var activeFieldBorderColor = UIColor.green
    var isBottomLineEnabled = false
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //Customisation and setting stackView
    public final func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = CGFloat(tfSpacing)
    }
    
    //Adding each OTPfield to stack view
    public final func addOTPFields() {
        
        if numberOfFields == 4 || numberOfFields == 6 {
            
            for index in 0..<numberOfFields{
                let field = OTPTextField()
                setupTextField(field)
                textFieldsCollection.append(field)
                //Adding a marker to previous field
                index != 0 ? (field.previousTextField = textFieldsCollection[index-1]) : (field.previousTextField = nil)
                //Adding a marker to next field for the field at index-1
                index != 0 ? (textFieldsCollection[index-1].nextTextField = field) : ()
            }
            textFieldsCollection[0].becomeFirstResponder()
            
        } else {
            print("number of fields must be 4 or 6")
        }
        
    }
    
    //Customisation and setting OTPTextFields
    private final func setupTextField(_ textField: OTPTextField) {
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(textField)
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 40).isActive = true
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.font = textFont
        if isBottomLineEnabled {
            textField.addBottomBorderWithColors(color: .systemPink, width: 1.0)
        } else {
            textField.backgroundColor = textBackgroundColor
            textField.textColor = textColor
            textField.layer.cornerRadius = CGFloat(tfCornerRadius)
            textField.layer.borderWidth = CGFloat(borderWidth)
            textField.layer.borderColor = inactiveFieldBorderColor.cgColor
        }
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .yes
        textField.textContentType = .oneTimeCode
    }
    
    //checks if all the OTPfields are filled
    private final func checkForValidity() {
        for fields in textFieldsCollection {
            if (fields.text == "") {
                delegate?.didChangeValidity(isValid: false)
                return
            }
        }
        delegate?.didChangeValidity(isValid: true)
    }
    
    //gives the OTP text
    final func getOTP() -> String {
        var OTP = ""
        for textField in textFieldsCollection{
            OTP += textField.text ?? ""
        }
        return OTP
    }
    
    //set isWarningColor true for using it as a warning color
    final func setAllFieldColor(isWarningColor: Bool = false, color: UIColor){
        for textField in textFieldsCollection{
            textField.layer.borderColor = color.cgColor
        }
        showsWarningColor = isWarningColor
    }
    
    //autofill textfield starting from first
    private final func autoFillTextField(with string: String) {
        remainingStrStack = string.reversed().compactMap{String($0)}
        for textField in textFieldsCollection {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
            } else {
                break
            }
        }
        checkForValidity()
        remainingStrStack = []
    }
    
}

//MARK: - TextField Handling
extension OTPStackView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if showsWarningColor {
            setAllFieldColor(color: inactiveFieldBorderColor)
            showsWarningColor = false
        }
        textField.layer.borderColor = activeFieldBorderColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkForValidity()
        textField.layer.borderColor = inactiveFieldBorderColor.cgColor
    }
    
    //switches between OTPTextfields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else { return true }
        if string.count > 1 {
            textField.resignFirstResponder()
            autoFillTextField(with: string)
            return false
        } else {
            if (range.length == 0){
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                } else {
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }
    
}

class OTPTextField: UITextField {
    
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    
    override public func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
    }
}

//MARK: - Add bottom line
extension UIView {
    func addBottomBorderWithColors(color: UIColor, width: CGFloat){
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 52 , width: 40 , height: width)
        self.layer.addSublayer(border)
    }
}

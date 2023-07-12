//
//  ViewController.swift
//  OTP
//
//  Created by sismac020 on 26/06/23.
//

import UIKit

class OTPViewController: UIViewController, OTPFieldDelegete, UITextFieldDelegate {
    
    @IBOutlet weak var otpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otpView.backgroundColor = .clear
        createOTPField(withSequence: false)
    }
}

extension OTPViewController {
    
    func createOTPField(withSequence: Bool){
        if withSequence{
            enterOtpWithSequence(numOfFields: 4)
        } else {
            enterOtpWithoutSequence(numOfFields: 4)
        }
    }
    
    func enterOtpWithoutSequence(numOfFields: UInt) {
        let stackView = OTPStackView()
        
        //Customisation
        stackView.numberOfFields = Int(numOfFields)
        stackView.isBottomLineEnabled = true
        stackView.backgroundColor = .white
        stackView.textBackgroundColor = .lightGray
        stackView.activeFieldBorderColor = .white
        stackView.inactiveFieldBorderColor = .white
        
        //Add textFields
        stackView.setupStackView()
        stackView.addOTPFields()
        self.otpView.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: otpView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: otpView.centerYAnchor).isActive = true
    }
    
    func enterOtpWithSequence(numOfFields: UInt) {
        
        if numOfFields == 4 || numOfFields == 6 {
            
            lazy var otpField: OTPField = {
                let field = OTPField()
                field.slotCount = numOfFields
                field.slotPlaceHolder = ""
                field.enableUnderLineViews = true
                
                //Animation
                field.animationType = .flipFromLeft
                field.isAnimationEnabledOnLastDigit = false
                
                //Customisation
                field.filledSlotBackgroundColor = .clear
                field.filledSlotTextColor = .black
                field.emptySlotTextColor = .red
                field.emptySlotBackgroundColor = .lightGray
                field.slotCornerRaduis = 8
                field.isBorderEnabled = false
                field.emptySlotBorderWidth = 1
                field.filledSlotBorderWidth = 3
                field.filledSlotBorderColor = UIColor.black.cgColor
                
                field.build()
                return field
            }()
            
            self.view.addSubview(otpField)
            otpField.frame = CGRect(x: 16, y: self.view.frame.midY - 30, width: self.view.frame.width - 32, height: 70)
            otpField.otpDelegete = self
            otpField.animationType = .flipFromLeft
            
        } else {
            print("number of fields must be 4 or 6")
        }
        
    }
    
    func didEnterLastDigit(otp: String) {
        print(otp) // Here's the Digits
    }
    
}



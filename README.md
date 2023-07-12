# Swift-otp-View
OTP Screen Documentation

Objectives :
The objective of the OTP Screen is to provide an easy and customizable way to integrate an OTP (One-Time Password) view into your iOS application. This documentation will guide you through the process of integrating the OTP screen, including various customization options such as color, animations, and fonts.

Overview :
The OTP Screen allows you to display OTP fields with different layouts and animations based on your needs.

Integration :

CocoaPods
To integrate the OTP Screen into your project using CocoaPods, follow these steps:-

Add the following line to your Podfile:
pod ‘Swift-otp-View'

Run the following command in your terminal to fetch the latest version:
pod repo update

Usage
Once you have integrated the Swift-otp-View into your project, you can start using it in your code.

Import the Swift-otp-View module into your Swift file:
import Swift-otp-View

Initialising the Component
To create an OTP field, use the following function:

func createOTPField(withSequence: Bool){

        if withSequence{
            enterOtpWithSequence(numOfFields: 4)
        } else {
            enterOtpWithoutSequence(numOfFields: 4)
        }
 }

Enter OTP With Sequence
Enter OTP With Sequence to display OTP fields with a sequence, use the following function:

func enterOtpWithSequence(numOfFields: UInt) {

        if numOfFields == 4 || numOfFields == 6 {
            lazy var otpField: OTPField = {
                let field = OTPField()
                field.slotCount = numOfFields
                field.slotPlaceHolder = ""
                field.enableUnderLineViews = true
                
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


Enter OTP Without Sequence
To display OTP fields without a sequence, use the following function:

func enterOtpWithoutSequence(numOfFields: UInt) {

        let stackView = OTPStackView()
                
        //Add textFields
        stackView.setupStackView()
        stackView.addOTPFields()
        self.otpView.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: otpView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: otpView.centerYAnchor).isActive = true
 }

That's it! You have successfully integrated the OTP Screen into your iOS application. You can now customise the OTP view by modifying the provided options and further enhance the user experience in your app.

Note: Make sure to replace otpView with the actual view in your code where you want to display the OTP fields.


OTP Recordings:-

https://github.com/sparxit/Swift-otp-View/assets/1691769/612e1ff5-2e10-42ec-a633-f9b66898a547



https://github.com/sparxit/Swift-otp-View/assets/1691769/52f124a7-004d-4c1d-9d1a-741ececc29b0



https://github.com/sparxit/Swift-otp-View/assets/1691769/5a2444a9-b606-45d4-adb2-ab2c25ee9085


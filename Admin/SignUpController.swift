//
//  SignUpController.swift
//  Admin
//
//  Created by Macintosh on 2018/5/9.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit

class SignUpController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoButton.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        emailText.addTarget(self, action: #selector(buttonEnable), for:.editingChanged)
        passwordText.addTarget(self, action: #selector(buttonEnable), for:.editingChanged)
        userNameText.addTarget(self, action: #selector(buttonEnable), for:.editingChanged)
        // Do any additional setup after loading the view.
    }
    @IBAction func backToSignInPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func buttonEnable(){
        if let isEmailValue = emailText.text?.count,let isUserNameValue = userNameText.text?.count,let isPasswordValue = passwordText.text?.count{
            if isEmailValue > 0 && isUserNameValue > 0 && isPasswordValue > 0 {
                signUpButton.isEnabled = true
                signUpButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
            }else{
                signUpButton.isEnabled = false
                signUpButton.backgroundColor =  UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
            }
        }
    }
    
    @objc func handlePlusPhoto(){
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Library", style: .default) { (action) in
            self.handlePlusPhotoLibrary()
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action3 = UIAlertAction(title: "Camera", style: .default) {(_)in
            self.cameraPlusPhoto()
        }
        action2.setValue(UIColor.red, forKey: "titleTextColor")
        sheet.addAction(action1)
        sheet.addAction(action2)
        sheet.addAction(action3)
        present(sheet, animated: true, completion: nil)
     
    }
    
    func handlePlusPhotoLibrary(){
        let imagePickUpControl = UIImagePickerController()
        imagePickUpControl.delegate = self
        imagePickUpControl.sourceType = .photoLibrary
        imagePickUpControl.allowsEditing = true
        present(imagePickUpControl, animated: true, completion: nil)
    }

    func cameraPlusPhoto(){
        let cameraPickUpControl = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            cameraPickUpControl.delegate = self
            cameraPickUpControl.sourceType = UIImagePickerControllerSourceType.camera
            cameraPickUpControl.cameraCaptureMode = .photo
            cameraPickUpControl.modalPresentationStyle = .fullScreen
            present(cameraPickUpControl, animated: true, completion: nil)
        }else{
            let alertVC = UIAlertController(
                title: "No Camera",
                message: "Sorry, this device has no camera",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "OK",
                style:.default,
                handler: nil)
            alertVC.addAction(okAction)
            present(
                alertVC,
                animated: true,
                completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            addPhotoButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for:.normal)
            
        }else if let orignalImage = info["UIImagePickerControllerOriginalImage"]as?UIImage{
            addPhotoButton.setImage(orignalImage.withRenderingMode(.alwaysOriginal), for:.normal)
            
        }
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width/2
        addPhotoButton.layer.masksToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

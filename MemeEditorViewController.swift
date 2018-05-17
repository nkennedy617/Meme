//
//  MemeEditorViewController.swift
//  imagepicker
//
//  Created by Nell  Kennedy on 4/6/18.
//  Copyright © 2018 Nell  Kennedy. All rights reserved.
//

import UIKit
import Photos


class MemeEditorViewController: BaseViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate
{
    //MARK: - IBOutlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var ImagePickerToolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var ActionButton: UIBarButtonItem!
    @IBOutlet weak var ShareNavBar: UIToolbar!
    

    
    // Meme setup
    var memedImage = UIImage()
    var meme:Meme!
    
    let MemeDelegate = MemeTextFieldDelegate()
    //stroke width negative to make it solid/filled
    //I don't own Impact font, I have no legal claim to it so I am not going to include it
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3]
   
    
    
   
    
    //  - viewDIdLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setu checkPermission()
        checkPermission()
        
        prepareTextField(textField: topTextField, defaultText: "TOP")
        prepareTextField(textField: bottomTextField, defaultText: "BOTTOM")
        
        self.topTextField.delegate = MemeDelegate
        self.bottomTextField.delegate = MemeDelegate
        
      
        ActionButton.isEnabled = false
        
        self.tabBarController?.tabBar.isHidden = true
       
    }

    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        subscribeToKeyboardNotifications()

    }
    
    // MARK:- viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func pick(sourceType: UIImagePickerControllerSourceType){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        if ( imagePicker.sourceType == .photoLibrary )
        {
            imagePicker.allowsEditing = false
        }
        imagePicker.delegate = self
        ActionButton.isEnabled = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // pickAnImageFromAlbum
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        pick(sourceType: .photoLibrary )
        
    }
    
    // pickAnImageFromCamera
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        pick(sourceType: .camera)
        
    }
   
    // imagePickerController
    override func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        if let image = pickedImage {
                imagePickerView?.image = image
                imagePickerView.contentMode = .scaleAspectFit
            
                dismiss(animated: true, completion: nil)
        }
    }
    
    // imagePickerControllerDidCancel
    @objc private func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // checkPermission
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized: print("Access is granted by user")
        case .notDetermined: PHPhotoLibrary.requestAuthorization({
            (newStatus) in print("status is (newStatus)")
            if newStatus == PHAuthorizationStatus.authorized {
                // do stuff here */ print("success")
                
            }
            })
            case .restricted:
                print("User do not have access to photo album.")
            case .denied:
                 print("User has denied the permission.")
            }
        }
    //MARK:  Notifications
    // subscribeToKeyboardNotifications
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    // unsubscribeFromKeyboardNotifications
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    //MARK:  Keyboard Items
    //keyboardWillShow
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {  //Only if the bottom text field is selected we slide the view
            //slide the view
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
        
    }
    
    // keyboardWillHide
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    // getKeyboardHeight
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //MARK: MemeFunctions
    //  save
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    //  generateMemedImage
    func generateMemedImage() -> UIImage {
        ShareNavBar.isHidden = true
        ImagePickerToolbar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        ShareNavBar.isHidden = false
        ImagePickerToolbar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        
        return memedImage
    }
    
    // activityviewcontroller
    @IBAction func shareMeme(_ sender: UIBarButtonItem)
    {
        let shareMeme = generateMemedImage()
        let activityPicker = UIActivityViewController(activityItems: [shareMeme], applicationActivities: nil)
        activityPicker.completionWithItemsHandler = { (activityPicker, success, items, error) in
            
            if success {
                self.save()
            }
        }
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad{
            
            
            activityPicker.popoverPresentationController?.barButtonItem = ActionButton
            
        }
        
        present(activityPicker, animated: true, completion: nil)
       
        
        
    }
    
    @IBAction func cancel(_ sender: Any){
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        ActionButton.isEnabled = false
        imagePickerView.image = nil
    }
    
    func prepareTextField(textField: UITextField, defaultText: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = defaultText
    }
    
    
}


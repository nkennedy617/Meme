//
//  MemeDetailViewController.swift
//  FinalMeme
//
//  Created by Nell  Kennedy on 5/4/18.
//  Copyright © 2018 Nell  Kennedy. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController, UITextFieldDelegate {

    //calling memes from array in Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes: [Meme] {
        return appDelegate.memes
        
    }
    
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let MemeDelegate = MemeTextFieldDelegate()
    //stroke width negative to make it solid/filled
    //I don't own Impact font, I have no legal claim to it so I am not going to include it
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //prepareTextField(textField: topTextField, defaultText: "TOP")
        //prepareTextField(textField: bottomTextField, defaultText: "BOTTOM")
        //self.topTextField.delegate = MemeDelegate
        //self.bottomTextField.delegate = MemeDelegate
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MemeDetail")
        //self.topTextField.text = self.meme.topText
        self.imageView!.image =  self.meme.memedImage
        //self.bottomTextField.text = self.meme.bottomText
    }

    func prepareTextField(textField: UITextField, defaultText: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = defaultText
    }
}

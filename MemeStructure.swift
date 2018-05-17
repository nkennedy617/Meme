//
//  MemeStructure.swift
//  imagepicker
//
//  Created by Nell  Kennedy on 4/19/18.
//  Copyright © 2018 Nell  Kennedy. All rights reserved.
//

import Foundation
import UIKit

//Mark: Meme Structure
struct Meme {
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memedImage:  UIImage
    

}

class MemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
}


class MemeTableViewCell: UITableViewCell {
    //problem with the tableview row size/memed image display - found the below recommendation on stackoverflow
    //while it doesn't quite give me the look I was hoping for, it honestly looked pretty sharp
    //reference:  https://stackoverflow.com/questions/30424799/uitableviewcell-imageview-not-scaling-properly
   
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 0, y: 0, width: 112.5, height: 75)    //approx landscape image dimensions
        self.imageView?.backgroundColor = UIColor.black
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
}

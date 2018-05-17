//
//  MemeCollectionViewController.swift
//  FinalMeme
//
//  Created by Nell  Kennedy on 5/5/18.
//  Copyright © 2018 Nell  Kennedy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController {

    //calling memes from array in Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes: [Meme] {
        return appDelegate.memes
        
    }
    
    let cellSpacing = CGFloat(5)
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(createMeme))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        let space:CGFloat = 5.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        flowLayout.sectionInsetReference = .fromSafeArea
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView?.reloadData()
    }

    @objc func createMeme() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
            self.navigationController!.pushViewController(controller, animated: true)
        }
    }
    
   

  //  override func viewWillLayoutSubviews() {
    //    let imageSideLength: CGFloat
      //  let screenSize = UIScreen.main.bounds.size
        
        //if screenSize.height > screenSize.width {
          //  imageSideLength = (view.frame.width - (2 * cellSpacing)) / 3
        //} else {
         //   imageSideLength = (view.frame.width - (4 * cellSpacing)) / 5
        //}
        
        //flowLayout.itemSize = CGSize(width: imageSideLength, height: imageSideLength)
    //}

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("in cellcreation")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        let memeIndex = (indexPath as NSIndexPath).row
        
        let meme = memes[memeIndex]
        // Configure the cell...
        cell.memeImageView?.image =  meme.memedImage
        
         print(cell.memeImageView)
        //cell.textLabel?.text = meme.topText 
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    

}

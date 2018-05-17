//
//  MemeTableViewController.swift
//  FinalMeme
//
//  Created by Nell  Kennedy on 5/3/18.
//  Copyright © 2018 Nell  Kennedy. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController{

    //calling memes from array in Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes: [Meme] {
        return appDelegate.memes
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(createMeme))
       
        
    }

    @objc func createMeme() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
            self.navigationController!.pushViewController(controller, animated: true)
        }
    }
    
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }


    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("table view func")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! MemeTableViewCell
        let memeIndex = (indexPath as NSIndexPath).row
        
        let meme = memes[memeIndex]
        // Configure the cell...
        cell.imageView?.image =  meme.memedImage
        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
        
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 144.0
        

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    
    }
   
}

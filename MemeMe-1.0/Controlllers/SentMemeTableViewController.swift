//
//  SentMemeTableViewController.swift
//  MemeMe-1.0
//
//  Created by Enemona Okeme on 27/04/2020.
//  Copyright © 2020 shamnex. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - IBOUTLETS
    
    @IBOutlet weak var _tableView: UITableView!
    
    // MARK: - VARIABLES

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: - LIFE CYCLE HOOKS
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        _tableView!.reloadData()
        
    }
    
    // MARK: - TABLEVIEW CONFIGS

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        
        cell.configureCell(meme: meme)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let selectedMeme = memes[indexPath.row]
        
        let memeDetail = storyboard?.instantiateViewController(
            identifier: "MemeDetailViewController") as! MemeDetailViewController
        
        memeDetail.meme = selectedMeme
        
        navigationController?.pushViewController(
            memeDetail, animated: true)
    }
    
    
    

    
    
    
    
    
}

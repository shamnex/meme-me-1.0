//
//  SentMemeCollectionViewController.swift
//  MemeMe-1.0
//
//  Created by Enemona Okeme on 27/04/2020.
//  Copyright © 2020 shamnex. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    @IBOutlet weak var uiCollectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        uiCollectionView.reloadData()

    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
     setupView()
    }
    
 
    
    func setupView() {
        let space: CGFloat
        let dimension: CGFloat
        
        if (UIDevice.current.orientation.isPortrait) {
             space = 3.0
             dimension = (view.frame.size.width - (2 * space)) / 3 //3 per line
         } else {
             space = 1.0
             dimension = (view.frame.size.width - (1 * space)) / 5
         }
         
        flowLayout.minimumLineSpacing = space

         flowLayout.minimumInteritemSpacing = space
         flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count + 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
//         cell.configureCell(meme: memes[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    
}

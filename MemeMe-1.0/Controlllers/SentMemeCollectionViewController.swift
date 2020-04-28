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
        if UIDevice.current.orientation.isLandscape {
            setupLandScapeView( view.frame.size)
        } else {
            setupPortratView( view.frame.size)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uiCollectionView.reloadData()

    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            setupLandScapeView(size)
        } else {
            setupPortratView(size)
        }
    }
    
    func setupPortratView(_ size: CGSize?) {
        let viewWidth = size?.width ?? view.frame.size.width
        let space:CGFloat = 3.0
        let dimention = (viewWidth - (2 * space)) / ( 3.0 )
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimention, height: dimention)
    }
    
    func setupLandScapeView(_ size: CGSize?) {
        
        
        let height = size?.width ?? view.frame.size.width
        let space:CGFloat = 3.0
        let dimention = (height - 3 * space) / ( 4.0)
    
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimention, height: dimention)
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
         cell.configureCell(meme: memes[indexPath.item])
        
        return cell
    }
    
    
    
}

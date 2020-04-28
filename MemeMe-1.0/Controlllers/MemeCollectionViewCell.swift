//
//  MemeCollectionViewCell.swift
//  MemeMe-1.0
//
//  Created by Enemona Okeme on 27/04/2020.
//  Copyright © 2020 shamnex. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    
   func configureCell(meme: Meme) {
        memeImageView.image = meme.memedImage
    }
    
}

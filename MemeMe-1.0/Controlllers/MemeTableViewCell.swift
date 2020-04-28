//
//  MemeCell.swift
//  MemeMe-1.0
//
//  Created by Enemona Okeme on 27/04/2020.
//  Copyright © 2020 shamnex. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var topMemeText: UILabel!
    
    @IBOutlet weak var bottomMemeText: UILabel!
    
    @IBOutlet weak var memeImage: UIImageView!
    
    func configureCell(meme: Meme) {
        topMemeText.text = meme.topText
        bottomMemeText.text = meme.bottomText
        memeImage.image = meme.memedImage
    }
}

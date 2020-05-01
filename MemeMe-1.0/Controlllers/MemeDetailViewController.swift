//
//  MemeDetailViewController.swift
//  MemeMe-1.0
//
//  Created by Enemona Okeme on 01/05/2020.
//  Copyright © 2020 shamnex. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memImage: UIImageView!
    var meme : Meme?
    override func viewDidLoad() {
        if let meme = meme {
            memImage.image = meme.memedImage
        }
        super.viewDidLoad()
    }
    
}

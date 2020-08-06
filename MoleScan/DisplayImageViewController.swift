//
//  DisplayImageViewController.swift
//  MoleScan
//
//  Created by 65,115,114,105,116,104,98 on 7/30/20.
//  Copyright © 2020 Asritha Bodepudi. All rights reserved.
//

import UIKit
import RealmSwift
class DisplayImageViewController: UIViewController {
    let realm = try! Realm()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    var mole = Entry()
    override func viewDidLoad() {
        super.viewDidLoad()
        if mole != nil{
            print (mole)
        }
        
        imageView.image = UIImage(data: (mole.imageOfMole!) as Data)
        textView.text = mole.diagnosis
      if mole.diagnosis == "RESULT: The inputted image shows a malignant mole."{
            textView.textColor = UIColor.red
        }
        else{
            textView.textColor = UIColor.green
        }

    }
    
}

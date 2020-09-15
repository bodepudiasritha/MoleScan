//
//  ViewController.swift
//  Mole Scan App
//
//  Created by Vidushi Meel on 7/14/20.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    let realm = try! Realm()

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func someButton(_ sender: Any) {
        imageView.isHidden = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isHidden = true

        // Do any additional setup after loading the view.

    }


}


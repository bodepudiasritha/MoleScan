//
//  BodyViewController.swift
//  MoleScan
//
//  Created by 65,115,114,105,116,104,98 on 7/30/20.
//  Copyright © 2020 Asritha Bodepudi. All rights reserved.
//

import UIKit
import RealmSwift

class BodyViewController: UIViewController {
    let realm = try! Realm()
    
    @IBOutlet weak var bodyImage: UIImageView!
    var tap = UITapGestureRecognizer()
    var moleToPass = Entry()
    let shapeLayer = CAShapeLayer()
    var point = CGPoint(x: 0, y: 0)
    var counter = 0
    var moleLayers: [CAShapeLayer] = []
    var molePaths: [CGPoint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.layer.addSublayer(shapeLayer)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(BodyViewController.tappedMe))
        
        bodyImage.addGestureRecognizer(tap)
        bodyImage.isUserInteractionEnabled = true
        
        
        if realm.objects(Entry.self).count != 0{
            for object in realm.objects(Entry.self) {
                let mole = CGPoint(x: CGFloat(object.positionOnBodyXCoordinate), y: CGFloat(object.positionOnBodyYCoordinate))
                let circlePath = UIBezierPath(arcCenter: mole, radius: CGFloat(5), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
                let moleLayer = CAShapeLayer()
                molePaths.append(mole)
                moleLayer.path = circlePath.cgPath
                moleLayer.fillColor = UIColor.blue.cgColor
                moleLayer.strokeColor = UIColor.blue.cgColor
                moleLayer.lineWidth = 3.0
                moleLayers.append(moleLayer)
                view.layer.addSublayer(moleLayer)
                
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch!.location(in: self.view)
        for layer in moleLayers {
            if layer.path!.contains(point){
                for object in realm.objects(Entry.self) {
                      let mole = CGPoint(x: CGFloat(object.positionOnBodyXCoordinate), y: CGFloat(object.positionOnBodyYCoordinate))
                    
                 //   moleLayers.firstIndex(of: layer)
                    
                    if mole == molePaths[moleLayers.firstIndex(of: layer)!] {
                        moleToPass = object
                    }
                }
                performSegue(withIdentifier: "displayMole", sender: self)
                
            }
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DisplayImageViewController
        {
            let vc = segue.destination as? DisplayImageViewController
            vc?.mole = moleToPass
        }
    }
    @objc func tappedMe()
    {
        
        point = tap.location(in: self.view)
        print (point)
        let circlePath = UIBezierPath(arcCenter: point, radius: CGFloat(10), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        if point != CGPoint(x: 0, y: 0){
            performSegue(withIdentifier: "confirmButtonPressed", sender: self)
            
            do {
                try self.realm.write{
                    let newEntry = Entry()
                    newEntry.positionOnBodyXCoordinate = Double(point.x)
                    newEntry.positionOnBodyYCoordinate = Double(point.y)
                    realm.add(newEntry)
                }
            }
            catch{
                print (error)
            }
            
        }
        else{
            let alert = UIAlertController(title: "Please select a spot on the  body", message: "You must select where your mole is present.", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                      self.present(alert, animated: true)

        }
    }
    
}

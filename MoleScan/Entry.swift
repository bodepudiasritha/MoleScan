//
//  Entry.swift
//  MoleScan
//
//  Created by 65,115,114,105,116,104,98 on 7/30/20.
//  Copyright © 2020 Asritha Bodepudi. All rights reserved.
//

import Foundation
import RealmSwift

class Entry: Object{

    @objc dynamic var positionOnBodyXCoordinate: Double = 0.0
    @objc dynamic var positionOnBodyYCoordinate: Double  = 0.0
    @objc dynamic var diagnosis: String = ""
    @objc dynamic var imageOfMole: NSData?
}

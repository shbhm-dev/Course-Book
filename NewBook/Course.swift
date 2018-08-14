//
//  Course.swift
//  NewBook
//
//  Created by STARKS on 8/13/18.
//  Copyright © 2018 STARKS. All rights reserved.
//

import Foundation
import  RealmSwift
class Course : Object{
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var price = ""
    @objc dynamic var imageNsData : NSData?
    
    
    
    
}

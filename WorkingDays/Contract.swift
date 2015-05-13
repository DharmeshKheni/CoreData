//
//  Contract.swift
//  WorkingDays
//
//  Created by Nikolay Dudrenov on 5/11/15.
//  Copyright (c) 2015 Nikolay Dudrenov. All rights reserved.
//

import Foundation
import CoreData

//@objc(Contract)
class Contract: NSManagedObject {

    @NSManaged var stratdate: String
    @NSManaged var enddate: String
    @NSManaged var ship: String
    @NSManaged var position: String
    @NSManaged var workingdays: String

}

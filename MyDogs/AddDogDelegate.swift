//
//  AddDogDelegate.swift
//  MyDogs
//
//  Created by Grant Brooks on 9/18/17.
//  Copyright © 2017 Grant Brooks. All rights reserved.
//

import Foundation
import UIKit


protocol AddDogDelegate: class {
    func cancelItem(by: Any)
    func saveItem(by: Any, name: String, color: String, treat: String, newImage: UIImage, indexPath: NSIndexPath?)

}

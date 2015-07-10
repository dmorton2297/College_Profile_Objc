//
//  College.swift
//  College_Profile_Objc
//
//  Created by Dan Morton on 7/9/15.
//  Copyright (c) 2015 Dan Morton. All rights reserved.
//

import Foundation
import UIKit

@objc class College : NSObject{
    var name : String
    var population : Int
    var image : UIImage
    init(collegeWithName name: String, collegeWithPopulation population: Int, collegeWithImage image: UIImage){
        self.name = name
        self.population = population
        self.image = image
    }
}
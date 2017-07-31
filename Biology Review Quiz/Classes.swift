//
//  Classes.swift
//  Biology Review Quiz
//
//  Created by Trevor Rose on 5/13/17.
//  Copyright © 2017 Trevor Rose. All rights reserved.
//

import Foundation

class postID {
    static var sharedInstance = postID()
    private init() { }
    
    var postKey: String!
}

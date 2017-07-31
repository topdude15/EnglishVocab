//
//  QuestionCell.swift
//  Biology Review Quiz
//
//  Created by Trevor Rose on 5/12/17.
//  Copyright © 2017 Trevor Rose. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import SwiftKeychainWrapper

class QuestionCell: UITableViewCell {

    @IBOutlet weak var questionBox: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(post: Post) {
        self.post = post
        self.questionBox.text = post.question
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

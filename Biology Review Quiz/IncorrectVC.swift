//
//  IncorrectVC.swift
//  Biology Review Quiz
//
//  Created by Trevor Rose on 5/11/17.
//  Copyright © 2017 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase

class IncorrectVC: UIViewController {

    @IBOutlet weak var infoBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let postKey = postID.sharedInstance.postKey
        
        FIRDatabase.database().reference().child("questions").child(postKey!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let info = dictionary["info"] as! String
                self.infoBox.text = info
            }
            
            
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "question", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

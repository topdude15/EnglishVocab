//
//  QuestionVC.swift
//  Biology Review Quiz
//
//  Created by Trevor Rose on 5/11/17.
//  Copyright © 2017 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class QuestionVC: UIViewController {

    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var definition: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var function: UILabel!
    @IBOutlet weak var sentence: UILabel!
    
    var postKey = "POST"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postKey = postID.sharedInstance.postKey
        
        FIRDatabase.database().reference().child("words").child(postKey).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let word = dictionary["word"]
                let definition = dictionary["definition"]
                let source = dictionary["exampleSource"]
                let function = dictionary["function"]
                let sentence = dictionary["sentence"]
                let image = dictionary["example"]
                
                self.word.text = word as? String
                self.definition.text = definition as? String
                self.source.text = source as? String
                self.function.text = function as? String
                self.sentence.text = sentence as? String
                
                let ref = FIRStorage.storage().reference(forURL: image as! String)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        print("Error \(String(describing: error)) ")
                    } else {
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.image.image = img
                            }
                        }
                    }
                })
                
                
//                let ref = FIRStorage.storage().reference(forURL: post.imageUrl as String)
//                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
//                    if error != nil {
//                        print("TREVOR: Unable to download image from Firebase storage")
//                    } else {
//                        if let imgData = data {
//                            if let img = UIImage(data: imgData) {
//                                self.postImg.image = img
//                                FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
//                            }

            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backToList(_ sender: Any) {
        performSegue(withIdentifier: "backToList", sender: nil)
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

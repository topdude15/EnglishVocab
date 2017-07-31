//
//  LoginVC.swift
//  Biology Review Quiz
//
//  Created by Trevor Rose on 5/11/17.
//  Copyright © 2017 Trevor Rose. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.delegate = self
        self.pwdField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let uid = FIRAuth.auth()?.currentUser
        if uid != nil {
            performSegue(withIdentifier: "list", sender: nil)
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let password = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("TREVOR: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            //Notification if creating the user was unsuccessful
                            print("TREVOR: Unable to authenticate email user with Firebase")
                            let message = "Verify your e-mail and password are correct and try again"
                            let alertController = UIAlertController(
                                title: "Unable to log in",
                                message: message,
                                preferredStyle: .alert
                            )
                            let okAction = UIAlertAction(title: "OK", style: .cancel) { _ -> Void in
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true)
                            
                        } else {
                            print("TREVOR: Successfully authenticated email user with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                print("TREVOR: \(userData)")
                                
                                //Create the Firebase user from the DataService sheet
                                
                                FIRDatabase.database().reference().child("users").child(user.uid).updateChildValues(userData)
                                
                                //Update the values for the email and password in their respective classes
                                print("TREVOR: Still here!")
                                self.performSegue(withIdentifier: "list", sender: nil)
                            }
                        }
                    })
                }
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("TREVOR: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "list", sender: nil)
    }


}

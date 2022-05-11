//
//  RegisterViewController.swift
//  Step Counter
//
//  Created by  Dhruv Rajpara on 2022-04-01.
//This ViewController will have functionallity to register a user
//

import UIKit

class RegisterViewController: UIViewController {
    
        @IBOutlet var tfName: UITextField!
        @IBOutlet var tfEmail: UITextField!
        @IBOutlet var tfPass: UITextField!
        @IBOutlet var tfPassRe: UITextField!
        
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //This function will be used to register a user
    //Author: Dhruv Rajpara
    func userRegister(){
       
        //generate data object
        let person : Data = Data.init()
      
      
        //add input with data object
        person.initWithData(theRow: 0, theName: tfName.text!, theEmail: tfEmail.text!, thePassword: tfPass.text!)
        
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
    
        let returnCode : Bool = mainDelegate.insertIntoDatabase(person: person)
        
     //if user is registered then it will show a message that Person is added
        var returnMSG : String = "Person Added"
        print(returnMSG)
        if returnCode == false
        {
            returnMSG = "Person Add Failed"
        }
        
        // move on to
    }
    
    //This action will be called when user clicks register button
    //Author: Dhruv Rajpara
    @IBAction func addPerson(sender : Any){
        
        //match paswords and call registration function
        if(tfPass.text! == tfPassRe.text!)
        {
        userRegister()
            let alert = UIAlertController(title: "Message", message: "You are registered!", preferredStyle: .alert)
            let inputButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(inputButton)
            present(alert, animated: true)
            
        }else{
            //this will show an alert if passowords are not match
                        let alert = UIAlertController(title: "Message", message: "Password does not match", preferredStyle: .alert)
                        let inputButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(inputButton)
                        present(alert, animated: true)
        }
        
    
    }
}

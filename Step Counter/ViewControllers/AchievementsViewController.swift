//
//  AchievementsViewController.swift
//  Step Counter
//
//  Created by  on 2022-04-04 Devansh Patel.
//

import UIKit
import Social
import FBSDKLoginKit

class AchievementsViewController: UIViewController {
   
   
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    // methods  to share achivement trophy
    @IBAction func shareAchivementTrophy(sender : Any) {
        print("button clicked")
       
        guard let image = UIImage(named: "trophy") else  {
            return
        }
        // create sharesheet and allow user to share their post
        let shareSheet = UIActivityViewController(activityItems: [image, "Share your achivement"], applicationActivities: nil)
        present(shareSheet, animated: true)
    }
    
    // methods  to share achivement star
    @IBAction func shareAchivementStar(sender : Any) {
        print("button clicked")
       
        guard let image = UIImage(named: "Star") else  {
            return
        }
        
        let shareSheet = UIActivityViewController(activityItems: [image, "Share your achivement"], applicationActivities: nil)
        present(shareSheet, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
            // genreate facebook login button
             let loginButton = FBLoginButton()
             let screenSize:CGRect = UIScreen.main.bounds
             let screenHeight = screenSize.height //real screen height
             //let's suppose we want to have 10 points bottom margin
             let newCenterY = screenHeight - loginButton.frame.height - 80
             let newCenter = CGPoint(x: view.center.x, y: newCenterY)
                     loginButton.center = newCenter
                     loginButton.permissions = ["public_profile", "email"]
                     view.addSubview(loginButton)
        // check if the token is avalable or not
        if let token = AccessToken.current,
               !token.isExpired {
               // User is logged in, do work such as go to next view controller.
       
        }
    
        //call the validateRegister from App Delegate to check user registered or not
        //Author: Dhruv Rajpara
        if(mainDelegate.validateRegister == true){
           
            //if registration successful then it will print in console
            print("validateUser Successful")
            
        }else{
            //if registration  is not successful then alert will be presented
           print("validateUser is not Successful")
           
                        let alert = UIAlertController(title: "Message", message: "You are not Registered \n Please register from Account Window in Settings", preferredStyle: .alert)
                        let inputButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(inputButton)
                        present(alert, animated: true)
        }
      

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   

}

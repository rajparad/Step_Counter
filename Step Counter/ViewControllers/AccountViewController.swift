//
//  AccountViewController.swift
//  Step Counter
//
//  Created by Dhruv Rajpara on 2022-04-01.
//  Author: Dhruv Rajpara
//  This ViewController will have functionallity to login user with G-mail and Apple.
//

import UIKit
import AuthenticationServices
import FBSDKLoginKit
import GoogleSignIn
class AccountViewController: UIViewController{
 

    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var lblLogIn: UILabel!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
   
    
    
    struct theData{
        var email : String
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // check if user is connected with face and will show logout button
        //Author Devansh Patel
        if let token = AccessToken.current,
               !token.isExpired {
               // User is logged in, do work such as go to next view controller.
            let loginButton = FBLoginButton()
            let screenSize:CGRect = UIScreen.main.bounds
            let screenHeight = screenSize.height //real screen height
            //let's suppose we want to have 10 points bottom margin
            let newCenterY = screenHeight - loginButton.frame.height - 80
            let newCenter = CGPoint(x: view.center.x, y: newCenterY)
                    loginButton.center = newCenter
                    loginButton.permissions = ["public_profile", "email"]
                    view.addSubview(loginButton)
            lblLogIn.text = "Your are login with facebook"
        }
        else{
        setUpSignInbtn()
        }

        // Do any additional setup after loading the view.
    }
    
    //To unwind Register view Controller
    @IBAction func unwindToAccountViewController(sender : UIStoryboardSegue) {
    }
//This action will check registered user from database and match it to and let user login
    //Author: Dhruv Rajpara
    @IBAction func loginUser(sender : Any){
    //reads all the data from database
        mainDelegate.readDataFromDatabase()
         
      
        //It will fetch all data from the database
          for data in mainDelegate.theData{
            
              //If Email and password is match below function will be executed
             if(data.email! == tfEmail.text! && data.password! == tfPassword.text!){
                 
                 //show alert message
                  let alert = UIAlertController(title: "Message", message: "You are logged in", preferredStyle: .alert)
                  let inputButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                  alert.addAction(inputButton)
                  present(alert, animated: true)
                 let font : UIFont  = UIFont.boldSystemFont(ofSize: 19)
                 //update the label with user name
                  lblLogIn.font = font
                  lblLogIn.text = "Logged in as: \(data.name!)"
              
               
              }else{
                  //if E-mail or password does not match then it will update the label
                  let font : UIFont  = UIFont.boldSystemFont(ofSize: 18)
                   lblLogIn.font = font
                  lblLogIn.text = "E-mail or Password incorrect"
                  
              }
              
          }
        
      }

    //Sing-in with google
    //Author: Dhruv Rajpara
    @IBAction func googleLoginUser(sender : Any){
        //Call the signInConfig object from app deledate
        GIDSignIn.sharedInstance.signIn(with: mainDelegate.signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            //if authentication successfull it will update the label
            let alert = UIAlertController(title: "Message", message: "You are logged in with Gmail", preferredStyle: .alert)
            let inputButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(inputButton)
            self.present(alert, animated: true)
            let font : UIFont  = UIFont.boldSystemFont(ofSize: 19)
            self.lblLogIn.font = font
            self.lblLogIn.text = "Sign in with Gmail Successful"
            print("Done")
        
        }
    }
    
    
    //Sign in with Apple id butoon setup
    //Author: Dhruv Rajpara
    func setUpSignInbtn(){
          let signInBtn = ASAuthorizationAppleIDButton()
           
           signInBtn.frame = CGRect(x:20, y:(UIScreen.main.bounds.size.height - 170), width:(UIScreen.main.bounds.size.width - 40), height: 50 )
           signInBtn.addTarget(self, action: #selector(signInActionBtn), for: .touchUpInside)
           self.view.addSubview(signInBtn)
       }
       
    //Author: Dhruv Rajpara
       @objc func signInActionBtn(){
           
           //Call the authorization provider
           let appleIdProvider = ASAuthorizationAppleIDProvider()
           //creating request
           let request = appleIdProvider.createRequest()
           //request wwill have email and full name
           request.requestedScopes = [.email, .fullName]
           let authorizationController = ASAuthorizationController(authorizationRequests: [request])
           authorizationController.delegate = self
           authorizationController.presentationContextProvider = self
           authorizationController.performRequests()
           
       }
      
   }

    //Author: Dhruv Rajpara
   extension AccountViewController : ASAuthorizationControllerDelegate{
       
       //if there is any error with appple id login alert will be shown
       func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
           let alert = UIAlertController(title: "error", message: "\(error.localizedDescription)", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
           present(alert, animated: true, completion: nil)
       }
       
       //if request is successful it will print info in console
       func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
           switch authorization.credential{
           case let credentials as ASAuthorizationAppleIDCredential:
               print(credentials.user)
               print(credentials.fullName?.givenName)
               print(credentials.fullName?.familyName)
               
            
           case let credentials as ASPasswordCredential:
               print(credentials.password)
            //if there any other error below alert will be presented
           default:
               let alert = UIAlertController(title: "Apple Sign In", message: "Something went wrong", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
               present(alert, animated: true, completion: nil)
           }
       }
   }
//required method to use sign with  apple
//Author: Dhruv Rajpara
   extension AccountViewController : ASAuthorizationControllerPresentationContextProviding{
       func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
           return view.window!
       }
}

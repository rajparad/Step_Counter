//
//  Data.swift
//  Step Counter
//
//  Created by Dhruv Rajpara on 2022-04-01.
//

import UIKit

//in this class id, name, email, password will be declared for register a user and initWithData() constructor will be used
//Author: Dhruv Rajpara
class Data: NSObject {
   

        var id: Int?
        var name: String?
        var email: String?
        var password: String?
    
  
       
        
    func initWithData(theRow i: Int, theName n: String, theEmail e: String, thePassword p: String){
            id = i
            name = n
            email = e
            password = p

        }
   
}

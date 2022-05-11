//
//  SettingsViewController.swift
//  Step Counter
//
//  Created by  on 2022-03-28 Devansh Patel.
//

import UIKit

class SettingsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
   
    
    var listData : Array<String> = []
    
    var identities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        listData = ["About", "Account", "Set Daily Goals"]
        identities = ["VAbout","VAccount", "VSetGoal"]
    }
         
    // MARK: - Table Methods
    
    // define Table Delegate method for number of cells to instantiate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }

    // define Table Delegate method for height for each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    // define how each cell should look and its data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        tableCell.textLabel?.text = listData[indexPath.row]
        
        tableCell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
        
    }
    
    // step 9 making cells editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // step 9b rigth swipe actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
    
        let more = UITableViewRowAction(style: .normal, title: "More", handler:
        {  action, index in
            print("More button tapped")
        }
        )
        more.backgroundColor = .lightGray
        
        let favourite = UITableViewRowAction(style: .normal, title: "Favourite", handler:
        { action, index in
            print("Favourites button tapped")
        }
        )
        favourite.backgroundColor = .orange
        
        let share = UITableViewRowAction(style: .normal, title: "Share", handler:
        { action, index in
            print("Share button tapped")
        }
        )
        share.backgroundColor = .blue
        
        return [share, favourite, more]
    }
    
    // left swipe actions
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
 
        let modifyAction = UIContextualAction(style: .normal, title: "Modify", handler:
        { ac, view, success in
            print("Modify button tapped")
            success(true)
        }
        )
         modifyAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
             //  what should go in each cell
            
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcName = identities[indexPath.row]
        print(vcName)
        performSegue(withIdentifier: vcName, sender: self)
    }

    @IBAction func unwindToSettingViewController(sender : UIStoryboardSegue) {
        
    }
  
}
    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



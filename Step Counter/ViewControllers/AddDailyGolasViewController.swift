//
//  AddDailyGolasViewController.swift
//  Step Counter
//
//  Created by  on 2022-04-07 Devansh Patel.
//

import UIKit

class AddDailyGolasViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet var lable :UILabel!
    @IBOutlet var pickView : UIPickerView!
    
    let data = ["1000","2000","5000","7000","10000","12000","15000","20000"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // wiil retrun the number of componenet
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // willl genreate the specific amount of row
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // set the lable text
        lable.text = data[row]
    }
    
    @IBAction func setGoal(sender : Any) {
        
        
        
       // gives alert msg once the goals are set
        let alert = UIAlertController(title: "Goal set", message: "Your goals has been set to \n" + lable.text! + " steps", preferredStyle: .alert)
        let inputButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(inputButton)
        present(alert, animated: true)
    }
    
    
    
    @IBAction func unwindToAccountViewController(sender : UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lable.text = "0"

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

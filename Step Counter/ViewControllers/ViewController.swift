//
//  ViewController.swift
//  Step Counter
//  The home tab. It displays the daily step count using HealthKit data.
//
//  Created by Mark Zarak on 2022-03-25.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
            
    var healthStore : HKHealthStore?
    var leftFadeLayer : CALayer?
    var rightFadeLayer : CALayer?
    @IBOutlet var lblStepCount : UILabel!
    
    // A method to authorize HealthKit access from user
   
    func authorizeHealthKit() {
        // Specify data to request
        let stepCount = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
        
        // Instantiate HealthKit Store and pass in request
        healthStore = HKHealthStore()
        healthStore!.requestAuthorization(toShare: [], read: stepCount) {( success, error) in
            if(success) {
                print("HealthKit permission granted.")
                self.getDailyStepCount()
            }
        }
    }
    
    // A method that retrieves the daily step count from the users stored HealthKit data
    func getDailyStepCount() {
        guard let sampleType = HKCategoryType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        // Build query to return total steps in current day
        let startDate = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        var interval = DateComponents()
        interval.day = 1
        let query = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate, intervalComponents: interval)
        
        query.initialResultsHandler = {
            query, result, error in
            if let myResult = result {
                myResult.enumerateStatistics(from: startDate, to: Date()) { (statistic, value) in
                    if let count = statistic.sumQuantity() {
                        let val = count.doubleValue(for: HKUnit.count())
                        self.updateStepCountLabel(stepCount: val)
                    }
                }
            }
        }
        
        healthStore?.execute(query)
    }
    
    // A method to update the step count label
    func updateStepCountLabel(stepCount : Double) {
        
        // Format step count and convert to string
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let stepCountNumber = NSNumber(value: stepCount)
        let formattedStepCount = formatter.string(from: stepCountNumber)
        
        // Used when a UI change is called on a background thread
        DispatchQueue.main.async {
            self.lblStepCount.text = formattedStepCount
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Check if HealthKit is available on the device
        if(HKHealthStore.isHealthDataAvailable()) {
            authorizeHealthKit()
        }
        
        // Add left foot print image layer to screen
        let leftFootprint = UIImage(named: "Left-Footprint.png")
        leftFadeLayer = CALayer.init()
        leftFadeLayer?.contents = leftFootprint?.cgImage
        leftFadeLayer?.bounds = CGRect(x: 0.0, y: 0.0, width: 49.0, height: 128.0)
        leftFadeLayer?.position = CGPoint(x: 120, y: 545)
        self.view.layer.addSublayer(leftFadeLayer!)
        
        // Add right foot print image layer to screen
        let rightFootprint = UIImage(named: "Right-Footprint.png")
        rightFadeLayer = CALayer.init()
        rightFadeLayer?.contents = rightFootprint?.cgImage
        rightFadeLayer?.bounds = CGRect(x: 0.0, y: 0.0, width: 49.0, height: 128.0)
        rightFadeLayer?.position = CGPoint(x: 260, y: 530)
        self.view.layer.addSublayer(rightFadeLayer!)
        
        // Add left fade animation
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeAnimation.fromValue = NSNumber.init(value: 1.0)
        fadeAnimation.toValue = NSNumber.init(value: 0.3)
        fadeAnimation.isRemovedOnCompletion = false
        fadeAnimation.duration = 5.0
        fadeAnimation.isAdditive = false
        fadeAnimation.fillMode =  CAMediaTimingFillMode.forwards
        fadeAnimation.repeatCount=Float.infinity
        leftFadeLayer?.add(fadeAnimation, forKey: "LeftFootprint")
        
        // Add right fade animation
        fadeAnimation.timeOffset = 2.5
        rightFadeLayer?.add(fadeAnimation, forKey: "RightFootprint")
        
    }
    
    @IBAction func unwindToHomeViewController(sender : UIStoryboardSegue) {
        
    }

}


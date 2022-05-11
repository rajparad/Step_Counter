//
//  SummaryViewController.swift
//  Step Counter
//
//  Created by Sukhdev Banwait on 2022-03-27.
//

import UIKit
import Charts

class SummaryViewController: UIViewController, ChartViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    
    // Data model: These strings will be the data for the table view cells
    let dayCounts: [String] = ["Mon : 200 Steps", "Tues : 100 Steps", "Wed : 200 Steps", "Thu : 300 Steps", "Fri : 400 Steps"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // make a barchart
    var barChart = BarChartView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        barChart.delegate = self
        
        // Register the table view cell class and its reuse id
        self.tblView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // set up and apply background image
        let backgroundImage = UIImage(named: "Logo.png")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFit
        self.tblView.backgroundView = imageView
        tblView.backgroundColor = .lightGray
        
        // remove extra bottom cell
        tblView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tblView.delegate = self
        tblView.dataSource = self
        
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dayCounts.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.tblView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        // set the text from the data model
        cell.textLabel?.text = self.dayCounts[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    
    // apply all subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // establish bar chart size, color, and positioning
        let numOfCols = 5
        let chartLength = self.view.frame.size.width / 1.5
        barChart.frame = CGRect(x: 0, y: 0, width: chartLength, height: chartLength)
        let chartX = view.frame.width / 2
        let chartY = 275.0
        barChart.center = CGPoint(x: chartX, y: chartY)
        let xAxis = barChart.xAxis
        xAxis.labelTextColor = .white
        xAxis.labelPosition = .bottom
        xAxis.granularity = 1
        
        // labels for bars
        let vals = ["Mon", "Tues", "Wed", "Thurs", "Fri"]
        xAxis.valueFormatter = IndexAxisValueFormatter(values: vals)
        barChart.leftAxis.labelTextColor = .white
        barChart.legend.enabled = false
        view.addSubview(barChart)
        // create entries for the bar chart inside an array of entries
        var entries = [BarChartDataEntry]()
        for x in 0..<numOfCols {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x * 100)))
        }
        let entry = BarChartDataEntry(x: 0.0, y: 200.0)
        
        entries[0] = entry
        let set = BarChartDataSet(entries:entries, label: "Days")
        set.colors = ChartColorTemplates.material()
        
        let data = BarChartData(dataSet: set)
        
        barChart.chartDescription.text = "Steps"
        
        barChart.data = data
    }
    
}


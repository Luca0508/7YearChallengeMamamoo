//
//  ViewController.swift
//  10YearChallengeMamamoo
//
//  Created by 蕭鈺蒖 on 2021/12/1.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var yearSlider: UISlider!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    let formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set a default date for date picker
        formatter.dateFormat = "yyyy-MM-dd"
        let startDateString = "2014-06-19"
        let startDate = formatter.date(from: startDateString)
        
        if let startDate = startDate {
            datePicker.setDate(startDate, animated: true)
        }
//        let startDate = DateComponents(calendar: Calendar.current,year: 2014, month: 6, day: 19).date
        
        
        
        
        
    }
    
    

    @IBAction func moveSlider(_ sender: UISlider) {
        
        // send the year from slider to label]
        let outputYear = String(Int(sender.value))
    
        yearLabel.text = outputYear
        
        let dateComponentPicker = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let month = dateComponentPicker.month
        let day = dateComponentPicker.day
        
        
        
        var imageName = String()
        var synDateString = String()
        if month!<10{
            imageName = "\(outputYear)0\(month!)01"
            synDateString = "\(outputYear)-0\(month!)-\(day!)"
        }else{
            imageName = "\(outputYear)\(month!)01"
            synDateString = "\(outputYear)-\(month!)-\(day!)"
        }
        
        if imageName.contains("201406"){
            imageName = "20140619"
        }
        
        mainImage.image = UIImage(named: imageName)
        
        formatter.dateFormat = "yyyy-MM-dd"
        let synDate = formatter.date(from: synDateString)
        
        if let synDate = synDate {
            datePicker.setDate(synDate, animated: true)
        }
        dateLabel.text = synDateString
        
        
    }
    
    @IBAction func getDate(_ sender: UIDatePicker) {

        // send the date from date picker to label
        formatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = formatter.string(from: sender.date)
        let dateComponent = Calendar.current.dateComponents(in: TimeZone.current, from: sender.date)
        let year = dateComponent.year
        
        //synchronize the slider
        if let year = year{
            yearSlider.setValue(Float(year), animated: true)
            yearLabel.text = String(year)
        }

        
        formatter.dateFormat = "yyyyMM"
        var imageName = formatter.string(from: sender.date)
        imageName += "01"
        
        if imageName.contains("201406"){
            imageName = "20140619"
        }
        
        mainImage.image = UIImage(named: imageName)
        

        
    }
    
    
}


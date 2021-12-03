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
    
    
    @IBOutlet weak var autoPlaySwitch: UISwitch!
    @IBOutlet weak var mainImage: UIImageView!
    let formatter = DateFormatter()
    var timer: Timer?
    var autoMonth = 6
    var autoYear = 2014
    
    
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
        
        let date
        
        
//        var imageName = String()
//        var synDateString = String()
//        if month!<10{
//            imageName = "\(outputYear)0\(month!)01"
//            synDateString = "\(outputYear)-0\(month!)-\(day!)"
//        }else{
//            imageName = "\(outputYear)\(month!)01"
//            synDateString = "\(outputYear)-\(month!)-\(day!)"
//        }
//
//        if imageName.contains("201406"){
//            imageName = "20140619"
//        }
//
//        mainImage.image = UIImage(named: imageName)
//
//        formatter.dateFormat = "yyyy-MM-dd"
//        let synDate = formatter.date(from: synDateString)
//
//        if let synDate = synDate {
//            datePicker.setDate(synDate, animated: true)
//        }
//        dateLabel.text = synDateString
        
        
    }
    
    @IBAction func getDate(_ sender: UIDatePicker) {
        
        let dateComponent = Calendar.current.dateComponents(in: TimeZone.current, from: sender.date)
        let year = dateComponent.year
        
        //synchronize the slider
        if let year = year{
            yearSlider.setValue(Float(year), animated: true)
            yearLabel.text = String(year)
        }
        
        getImageAndLabel(datePickerDate: sender.date)

    }
    
    func getImageAndLabel(datePickerDate: Date){
        formatter.dateFormat = "yyyyMM"
        var imageName = formatter.string(from: datePickerDate)
        imageName += "01"
        
        if imageName.contains("201406"){
            imageName = "20140619"
        }
        
        mainImage.image = UIImage(named: imageName)
        
        // send the date from date picker to label
        formatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = formatter.string(from: datePickerDate)
    }
    

    
    @IBAction func turnOnSwitch(_ sender: UISwitch) {
        if sender.isOn{
            timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: {(timer) in self.autoChangeDate()})
        }else{
            turnOffTimer()
        }
    }
    
    func turnOffTimer(){
        timer?.invalidate()
        autoMonth = 6
        autoYear = 2014
    }
    
    
    func autoChangeDate(){
        if self.autoMonth == 12, self.autoYear == 2021{
            turnOffTimer()
            autoPlaySwitch.isOn = false
            
        }else if self.autoMonth < 12{
            self.autoMonth += 1
        }else{
            self.autoYear += 1
            self.autoMonth = 1
        }
        
        var imageName = String()
        var synDateString = String()
        if autoMonth < 10{
            imageName = "\(autoYear)0\(autoMonth)01"
            synDateString = "\(autoYear)-0\(autoMonth)-01"
        }else{
            imageName = "\(autoYear)\(autoMonth)01"
            synDateString = "\(autoYear)-\(autoMonth)-01"
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

}


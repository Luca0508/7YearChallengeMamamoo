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
    let initialDate = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: 2014, month: 6, day: 19).date
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let initialDate = initialDate {
            datePicker.setDate(initialDate, animated: true)
        }
        
        

        
    }
    
    

    @IBAction func moveSlider(_ sender: UISlider) {
        
        // send the year from slider to label]
        let outputYear = String(Int(sender.value))
    
        yearLabel.text = outputYear
        
        let dateComponentPicker = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let month = dateComponentPicker.month
        let day = dateComponentPicker.day
        
        let date = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: Int(sender.value), month: month, day: day).date
        if let date = date{
            getImageAndLabel(datePickerDate: date)
            datePicker.setDate(date, animated: true)
        }
        
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
//            if let initialDate = initialDate {
//                datePicker.setDate(initialDate, animated: true)
//            }
            autoYear = 2014
            autoMonth = 5
            timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true, block: {(timer) in self.autoChangeDate()})
            
            
        }else{
            turnOffTimer()
            
        }
    }
    
    func turnOffTimer(){
        timer?.invalidate()
        autoMonth = 12
        autoYear = 2021
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
        
        let autoDate = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: autoYear, month: autoMonth, day: 1).date
        
        if let autoDate = autoDate{
            getImageAndLabel(datePickerDate: autoDate)
            datePicker.setDate(autoDate, animated: true)
            yearSlider.setValue(Float(autoYear), animated: true)
                
        }
    }

}


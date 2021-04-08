//
//  CalendarViewController.swift
//  SlideInTransition
//
//  Created by Murat on 10/13/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation
import FSCalendar
import EventKit

class CalendarViewController: UIViewController,FSCalendarDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var backgroundView: UIView!

    
//    //for add EVENT
//    @IBAction func btnAddEventTapped(_ sender: Any) {
//        let eventStore:EKEventStore = EKEventStore ()
//
//        eventStore.requestAccess(to: .event, completion: {(granted, error) in
//            if (granted ) && (error == nil)
//            {
//                print("granted \(granted)")
//                print("error \(String(describing: error))")
//
//                let event : EKEvent = EKEvent(eventStore: eventStore)
//                event.title = "VESTIUM"
//                event.startDate = Date()
//                event.endDate = Date()
//                event.notes = "This is a reminder from VESTIUM to check for weather"
//                event.calendar = eventStore.defaultCalendarForNewEvents
//                do {
//                    try eventStore.save(event, span: .thisEvent)
//                }catch let error as NSError{
//                    print("error: \(error)")
//                }
//                print ("Save Event")
//            }else{
//                print("error : \(String(describing: error))")
//            }
//        })
//    }


    // for WEATHER
     let gradientLayer = CAGradientLayer()
    //d7b0c00a3a37265a8e057a3a80b5c543
    let apiKey = "d7b0c00a3a37265a8e057a3a80b5c543"
    var lat = 11.344533
    var lon = 104.33322
    var activityIndicator: NVActivityIndicatorView!
    let locationManager = CLLocationManager()
    

   
    // for CALENDAR
    var calendar = FSCalendar ()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //for CALENDAR
        calendar.delegate = self
        
      
    
    
        //for WEATHER
        // backgroundView.layer.addSublayer(gradientLayer)
        
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width-indicatorSize)/2, y: (view.frame.height-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        activityIndicator.backgroundColor = UIColor.black
        view.addSubview(activityIndicator)
        
        locationManager.requestWhenInUseAuthorization()
        
        activityIndicator.startAnimating()
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    } // func viewDidLoad() ends
    
    
  
 
    // for CALENDAR
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = CGRect(x: 0, y: 80, width: view.frame.size.width, height: view.frame.size.width)
        view.addSubview(calendar)
    }// func viewDidLayoutSubviews()ends
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        print("\(string)")
    }// func calendar() ends
    
   


    // for WEATHER
    //    override func viewWillAppear(_ animated: Bool) {
    //        setBlueGradientBackground()
    //    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        // http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric").responseJSON {
            response in
            self.activityIndicator.stopAnimating()
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["main"]
                let iconName = jsonWeather["icon"].stringValue
                
                self.locationLabel.text = jsonResponse["name"].stringValue
                self.conditionImageView.image = UIImage(named: iconName)
                self.conditionLabel.text = jsonWeather["main"].stringValue
                self.temperatureLabel.text = "\(Int(round(jsonTemp["temp"].doubleValue*9/5+32)))"
                
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                self.dayLabel.text = dateFormatter.string(from: date)
                
                //                let suffix = iconName.suffix(1)
                //                if(suffix == "n"){
                //                    self.setGreyGradientBackground()
                //                }else{
                //                    self.setBlueGradientBackground()
                //                }
            }
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    //    func setBlueGradientBackground(){
    //        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
    //        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
    //        gradientLayer.frame = view.bounds
    //        gradientLayer.colors = [topColor, bottomColor]
    //    }
    //
    //    func setGreyGradientBackground(){
    //        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
    //        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
    //        gradientLayer.frame = view.bounds
    //        gradientLayer.colors = [topColor, bottomColor]
    //    }
    
    
    //for ADD EVENT
    
    
    
} // main ends


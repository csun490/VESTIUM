//
//  CalendarViewController.swift
//  SlideInTransition
//
//  Created by CSUN-Vestium on 10/13/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//
import UIKit
import FSCalendar

class CalendarViewController: UIViewController,FSCalendarDelegate {
    
    var calendar = FSCalendar ()
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = CGRect(x: 0, y: 80, width: view.frame.size.width, height: view.frame.size.width)
        view.addSubview(calendar)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        print("\(string)")
    }


}

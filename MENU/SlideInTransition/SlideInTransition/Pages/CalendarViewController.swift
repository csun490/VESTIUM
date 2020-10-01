//
//  CalendarViewController.swift
//  SlideInTransition
//
//  Created by Murat Bekgi on 9/29/20.
//  Copyright © 2020 Murat Bekgi. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController,FSCalendarDelegate {
    
    var calendar = FSCalendar ()
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

////
////  CalendarViewController.swift
////  GoalTracker
////
////  Created by Maha S on 20/12/2021.
////
//
//import UIKit
//import FSCalendar
//import QVRWeekView
//
//
//var currentDate = Date()
//
//class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, WeekViewDelegate {
//  func didLongPressDayView(in weekView: WeekView, atDate date: Date) {
//    //nothing
//  }
//
//  func didTapEvent(in weekView: WeekView, withId eventId: String) {
//    //nothing
//  }
//
//  func eventLoadRequest(in weekView: WeekView, between startDate: Date, and endDate: Date) {
//    //nothing
//  }
//
//
//  @IBOutlet weak var calendar: FSCalendar!
//  @IBOutlet weak var weekView: WeekView!
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    currentDate = Date()
//   selectDate(date: currentDate)
//
//    calendar.delegate = self
//    calendar.dataSource = self
//    calendar.scope = .week
//
//    weekView.delegate = self
//    weekView.mainBackgroundColor = UIColor.clear
//    weekView.todayViewColor = UIColor.clear
//    weekView.visibleDaysInPortraitMode = 1
//    weekView.defaultTopBarHeight = 0
//    weekView.defaultDayViewColor = UIColor.clear
//    weekView.passedDayViewColor = UIColor.clear
//    weekView.weekendDayViewColor = UIColor.clear
//    weekView.dayViewDashedSeparatorColor = UIColor.clear
//    weekView.sideBarWidth = 40
//    weekView.dayViewHourIndicatorColor = UIColor.darkGray
//  }
//
//  // select a specific day
//  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//    currentDate = date
//    selectDate(date: currentDate)
//  }
//
//
//  func activeDayChanged(in weekView: WeekView, to date: Date) {
//    currentDate = date
//    calendar.select(date)
//  }
//
//
//  func selectDate(date: Date) {
//    calendar.select(date)
//    weekView.showDay(withDate: date)
//
//  }
//}

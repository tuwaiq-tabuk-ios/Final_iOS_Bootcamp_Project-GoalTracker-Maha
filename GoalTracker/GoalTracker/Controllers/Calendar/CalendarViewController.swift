//////
//////  CalendarViewController.swift
//////  GoalTracker
//////
//////  Created by Maha S on 20/12/2021.



import HorizonCalendar

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addCalendarView()
    }
}


private extension CalendarViewController {
    
    func addCalendarView() {
        let calendarView = CalendarView(initialContent: makeContent())
        
        view.addSubview(calendarView)

        calendarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          calendarView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
          calendarView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
          calendarView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
          calendarView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }

    func makeContent() -> CalendarViewContent {
      let calendar = Calendar.current

      let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
      let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!

      return CalendarViewContent(
        calendar: calendar,
        visibleDateRange: startDate...endDate,
        monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
    }

  
  
}
  struct DayLabel: CalendarItemViewRepresentable {

    /// Properties that are set once when we initialize the view.
    struct InvariantViewProperties: Hashable {
      let font: UIFont
      let textColor: UIColor
      let backgroundColor: UIColor
    }

    /// Properties that will vary depending on the particular date being displayed.
    struct ViewModel: Equatable {
      let day: Day
    }

    static func makeView(
      withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
      -> UILabel
    {
      let label = UILabel()

      label.backgroundColor = invariantViewProperties.backgroundColor
      label.font = invariantViewProperties.font
      label.textColor = invariantViewProperties.textColor

      label.textAlignment = .center
      label.clipsToBounds = true
      label.layer.cornerRadius = 12
      
      return label
    }

    static func setViewModel(_ viewModel: ViewModel, on view: UILabel) {
      view.text = "\(viewModel.day.day)"
    }

  }


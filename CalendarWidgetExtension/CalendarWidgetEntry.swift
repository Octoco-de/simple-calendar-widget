import WidgetKit

struct CalendarWidgetEntry: TimelineEntry {
    let date: Date
    let monthData: MonthData
    let showAdjacentDays: Bool
}

struct MonthData: Sendable {
    let monthName: String
    let year: String
    let dayOfWeekHeaders: [String]
    let gridCells: [DayCell]
    let todayDay: Int?
}

struct DayCell: Identifiable, Sendable {
    let id: Int
    let dayNumber: Int
    let isCurrentMonth: Bool
    let isToday: Bool
}

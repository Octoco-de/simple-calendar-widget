import Foundation

struct MonthCalculator {

    static func computeMonth(
        baseDate: Date,
        monthOffset: Int,
        startDayOfWeek: Int
    ) -> MonthData {
        var calendar = Calendar.current
        calendar.firstWeekday = startDayOfWeek

        guard let targetDate = calendar.date(byAdding: .month, value: monthOffset, to: baseDate) else {
            fatalError("Could not compute target month")
        }

        let monthName = targetDate.formatted(.dateTime.month(.wide))
        let year = targetDate.formatted(.dateTime.year())
        let headers = dayOfWeekHeaders(calendar: calendar, startDayOfWeek: startDayOfWeek)
        let cells = gridCells(calendar: calendar, targetDate: targetDate, baseDate: baseDate, startDayOfWeek: startDayOfWeek)

        let todayComponents = calendar.dateComponents([.year, .month, .day], from: baseDate)
        let targetComponents = calendar.dateComponents([.year, .month], from: targetDate)
        let todayDay: Int? =
            (todayComponents.year == targetComponents.year &&
             todayComponents.month == targetComponents.month)
            ? todayComponents.day : nil

        return MonthData(
            monthName: monthName,
            year: year,
            dayOfWeekHeaders: headers,
            gridCells: cells,
            todayDay: todayDay
        )
    }

    private static func dayOfWeekHeaders(calendar: Calendar, startDayOfWeek: Int) -> [String] {
        let symbols = calendar.veryShortWeekdaySymbols
        let startIndex = startDayOfWeek - 1
        return (0..<7).map { offset in
            symbols[(startIndex + offset) % 7]
        }
    }

    private static func gridCells(
        calendar: Calendar,
        targetDate: Date,
        baseDate: Date,
        startDayOfWeek: Int
    ) -> [DayCell] {
        let components = calendar.dateComponents([.year, .month], from: targetDate)
        guard let firstOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstOfMonth)
        else { return [] }

        let daysInMonth = range.count
        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        let offset = (firstWeekday - startDayOfWeek + 7) % 7

        guard let prevMonthDate = calendar.date(byAdding: .month, value: -1, to: firstOfMonth),
              let prevRange = calendar.range(of: .day, in: .month, for: prevMonthDate)
        else { return [] }
        let daysInPrevMonth = prevRange.count

        let todayComps = calendar.dateComponents([.year, .month, .day], from: baseDate)
        let targetComps = calendar.dateComponents([.year, .month], from: targetDate)
        let isCurrentMonth = todayComps.year == targetComps.year && todayComps.month == targetComps.month

        let totalCells = offset + daysInMonth
        let rowCount = totalCells <= 28 ? 4 : (totalCells <= 35 ? 5 : 6)
        let cellCount = rowCount * 7

        var cells: [DayCell] = []
        for i in 0..<cellCount {
            let dayNumber: Int
            let isCurrent: Bool
            let isToday: Bool

            if i < offset {
                dayNumber = daysInPrevMonth - offset + 1 + i
                isCurrent = false
                isToday = false
            } else if i < offset + daysInMonth {
                dayNumber = i - offset + 1
                isCurrent = true
                isToday = isCurrentMonth && dayNumber == todayComps.day
            } else {
                dayNumber = i - offset - daysInMonth + 1
                isCurrent = false
                isToday = false
            }

            cells.append(DayCell(id: i, dayNumber: dayNumber, isCurrentMonth: isCurrent, isToday: isToday))
        }
        return cells
    }
}

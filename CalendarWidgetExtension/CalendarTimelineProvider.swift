import WidgetKit

struct CalendarTimelineProvider: AppIntentTimelineProvider {
    typealias Entry = CalendarWidgetEntry
    typealias Intent = CalendarWidgetIntent

    func placeholder(in context: Context) -> CalendarWidgetEntry {
        let data = MonthCalculator.computeMonth(baseDate: Date(), monthOffset: 0, startDayOfWeek: 1)
        return CalendarWidgetEntry(date: Date(), monthData: data, showAdjacentDays: true)
    }

    func snapshot(for configuration: CalendarWidgetIntent, in context: Context) async -> CalendarWidgetEntry {
        let data = MonthCalculator.computeMonth(
            baseDate: Date(),
            monthOffset: configuration.monthOffset,
            startDayOfWeek: configuration.startDayOfWeek.rawValue
        )
        return CalendarWidgetEntry(date: Date(), monthData: data, showAdjacentDays: configuration.showAdjacentDays)
    }

    func timeline(for configuration: CalendarWidgetIntent, in context: Context) async -> Timeline<CalendarWidgetEntry> {
        let now = Date()
        let calendar = Calendar.current

        let data = MonthCalculator.computeMonth(
            baseDate: now,
            monthOffset: configuration.monthOffset,
            startDayOfWeek: configuration.startDayOfWeek.rawValue
        )
        let currentEntry = CalendarWidgetEntry(date: now, monthData: data, showAdjacentDays: configuration.showAdjacentDays)

        guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: now) else {
            return Timeline(entries: [currentEntry], policy: .atEnd)
        }
        let startOfTomorrow = calendar.startOfDay(for: tomorrow)

        let tomorrowData = MonthCalculator.computeMonth(
            baseDate: startOfTomorrow,
            monthOffset: configuration.monthOffset,
            startDayOfWeek: configuration.startDayOfWeek.rawValue
        )
        let tomorrowEntry = CalendarWidgetEntry(date: startOfTomorrow, monthData: tomorrowData, showAdjacentDays: configuration.showAdjacentDays)

        return Timeline(entries: [currentEntry, tomorrowEntry], policy: .atEnd)
    }
}

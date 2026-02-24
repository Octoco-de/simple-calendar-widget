import AppIntents
import WidgetKit

enum StartDayOfWeek: Int, AppEnum, CaseIterable, Sendable {
    case sunday    = 1
    case monday    = 2
    case tuesday   = 3
    case wednesday = 4
    case thursday  = 5
    case friday    = 6
    case saturday  = 7

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Start Day of Week"

    static var caseDisplayRepresentations: [StartDayOfWeek: DisplayRepresentation] = [
        .sunday:    "Sunday",
        .monday:    "Monday",
        .tuesday:   "Tuesday",
        .wednesday: "Wednesday",
        .thursday:  "Thursday",
        .friday:    "Friday",
        .saturday:  "Saturday",
    ]
}

struct CalendarWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Calendar Widget"
    static var description: IntentDescription = "Displays a single month calendar view."

    @Parameter(title: "Start Day of Week", default: .sunday)
    var startDayOfWeek: StartDayOfWeek

    @Parameter(title: "Month Offset", default: 0)
    var monthOffset: Int
}

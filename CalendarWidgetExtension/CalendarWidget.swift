import SwiftUI
import WidgetKit

struct CalendarWidget: Widget {
    let kind: String = "CalendarWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: CalendarWidgetIntent.self,
            provider: CalendarTimelineProvider()
        ) { entry in
            CalendarGridView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Simple Calendar")
        .description("A simple monthly calendar grid.")
        .supportedFamilies([.systemSmall])
    }
}

@main
struct CalendarWidgetBundle: WidgetBundle {
    var body: some Widget {
        CalendarWidget()
    }
}

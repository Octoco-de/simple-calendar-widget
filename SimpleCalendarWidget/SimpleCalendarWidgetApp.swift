import SwiftUI

@main
struct SimpleCalendarWidgetApp: App {
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 16) {
                Image(systemName: "calendar")
                    .font(.system(size: 48))
                    .foregroundStyle(.secondary)
                Text("Simple Calendar Widget")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Add this widget to your Desktop or Notification Center from the widget gallery.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(40)
            .frame(minWidth: 300, minHeight: 200)
        }
        .windowResizability(.contentSize)
    }
}

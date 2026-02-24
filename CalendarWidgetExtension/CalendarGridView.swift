import SwiftUI
import WidgetKit

struct CalendarGridView: View {
    let entry: CalendarWidgetEntry

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 2),
        count: 7
    )

    private let accentRed = Color.red

    var body: some View {
        VStack(spacing: 4) {
            // Month name + year on the same line
            HStack(alignment: .firstTextBaseline) {
                Text(entry.monthData.monthName.uppercased())
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(accentRed)
                Spacer()
                Text(entry.monthData.year)
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundStyle(.primary)
            }

            // Day-of-week headers
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(Array(entry.monthData.dayOfWeekHeaders.enumerated()), id: \.offset) { _, header in
                    Text(header)
                        .font(.system(size: 9, weight: .semibold, design: .rounded))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 4)
                }
            }

            // Day number grid
            LazyVGrid(columns: columns, spacing: 3) {
                ForEach(entry.monthData.gridCells) { cell in
                    dayCellView(cell)
                }
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 10)
    }

    @ViewBuilder
    private func dayCellView(_ cell: DayCell) -> some View {
        if cell.isToday {
            Text("\(cell.dayNumber)")
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .frame(width: 18, height: 18)
                .background(
                    Circle().fill(accentRed)
                )
                .frame(maxWidth: .infinity)
        } else if cell.isCurrentMonth {
            Text("\(cell.dayNumber)")
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(.primary)
                .frame(height: 18)
                .frame(maxWidth: .infinity)
        } else if entry.showAdjacentDays {
            Text("\(cell.dayNumber)")
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundStyle(.quaternary)
                .frame(height: 18)
                .frame(maxWidth: .infinity)
        } else {
            Color.clear
                .frame(height: 18)
                .frame(maxWidth: .infinity)
        }
    }
}

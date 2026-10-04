import SwiftUI

struct QuantityStepper: View {
    @Binding var value: Int
    let range: ClosedRange<Int>
    let step: Int = 1

    var body: some View {
        HStack(spacing: 0) {
            Button {
                value = max(range.lowerBound, value - step)
            } label: {
                Image(systemName: "minus")
                    .frame(width: 44, height: 36)
            }

            Text("\(value)")
                .font(.headline)
                .monospacedDigit()
                .frame(minWidth: 52)
                .padding(.horizontal, 6)

            Button {
                value = min(range.upperBound, value + step)
            } label: {
                Image(systemName: "plus")
                    .frame(width: 44, height: 36)
            }
        }
        .buttonStyle(.bordered)                     
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Adet")
        .accessibilityValue("\(value)")
    }
}

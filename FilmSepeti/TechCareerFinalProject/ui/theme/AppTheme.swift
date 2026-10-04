import Foundation
import SwiftUI

enum AppTheme {
    static let primary = Color.purple
    static let bg      = Color(uiColor: .systemGroupedBackground)
    static func price(_ value: Int) -> String { "\(value) ₺" }
}

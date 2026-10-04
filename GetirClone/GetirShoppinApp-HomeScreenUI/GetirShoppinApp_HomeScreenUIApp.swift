import SwiftUI

@main
struct GetirShoppinApp_HomeScreenUIApp: App {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.systemGray3
    }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

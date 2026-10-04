import SwiftUI

enum RootTab: Int { case home, search, profile, gifts }

struct RootView: View {
    @State private var tab: RootTab = .home
    @State private var showMenu = false

    var body: some View {
        ZStack {
            TabView(selection: $tab) {
                NavigationStack { HomeScreen() }
                    .tag(RootTab.home)
                    .tabItem {
                        Image(tab == .home ? "home_selected" : "home").renderingMode(.original)
                        Text("")
                    }

                NavigationStack { Color.clear }
                    .tag(RootTab.search)
                    .tabItem {
                        Image(tab == .search ? "search_selected" : "search").renderingMode(.original)
                        Text("")
                    }

                NavigationStack { Color.clear }
                    .tag(RootTab.profile)
                    .tabItem {
                        Image(tab == .profile ? "profile_selected" : "profile").renderingMode(.original)
                        Text("")
                    }

                NavigationStack { Color.clear }
                    .tag(RootTab.gifts)
                    .tabItem {
                        Image(tab == .gifts ? "gift_selected" : "gift").renderingMode(.original)
                        Text("")
                    }
            }
            .tint(AppColors.getirPurple)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.white, for: .tabBar)

            CenterDockButton {
                showMenu.toggle()
            }
            .padding(.bottom, 22)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .zIndex(1)
        }
        .onAppear { hideTabBarTitles() }
    }
}

private func hideTabBarTitles() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white

    let clearAttr: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.clear]
    [appearance.stackedLayoutAppearance,
     appearance.inlineLayoutAppearance,
     appearance.compactInlineLayoutAppearance].forEach {
        $0.normal.titleTextAttributes = clearAttr
        $0.selected.titleTextAttributes = clearAttr
     }

    UITabBar.appearance().standardAppearance = appearance
    if #available(iOS 15.0, *) {
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

struct CenterDockButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(AppColors.getirPurple)
                    .frame(width: 60, height: 60)
                    .shadow(color: .black.opacity(0.2), radius: 10, y: 4)
                Image("menu")
                    .resizable().renderingMode(.original)
                    .scaledToFit().frame(width: 28, height: 28)
            }
        }
        .offset(y: -8)
    }
}

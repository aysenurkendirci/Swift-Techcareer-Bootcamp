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
                        Text("Ana")
                    }

                NavigationStack { Text("Ara") }
                    .tag(RootTab.search)
                    .tabItem {
                        Image(tab == .search ? "search_selected" : "search").renderingMode(.original)
                        Text("Ara")
                    }

                NavigationStack { Text("Profil") }
                    .tag(RootTab.profile)
                    .tabItem {
                        Image(tab == .profile ? "profile_selected" : "profile").renderingMode(.original)
                        Text("Profil")
                    }

                NavigationStack { Text("Hediye") }
                    .tag(RootTab.gifts)
                    .tabItem {
                        Image(tab == .gifts ? "gift_selected" : "gift").renderingMode(.original)
                        Text("Hediye")
                    }
            }
            .tint(AppColors.getirPurple)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.white, for: .tabBar)

            CenterDockButton {
                showMenu.toggle()
                // TODO: sheet/menü aç
            }
            .padding(.bottom, 22)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .zIndex(1)
        }
    }
}

struct CenterDockButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(AppColors.getirPurple)
                    .frame(width: 64, height: 64)
                    .shadow(color: .black.opacity(0.18), radius: 8, y: 4)
                Image("menu").renderingMode(.original)
                    .resizable().scaledToFit().frame(width: 28, height: 28)
            }
        }
        .offset(y: -8)
    }
}

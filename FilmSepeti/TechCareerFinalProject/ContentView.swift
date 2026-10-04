//
//  ContentView.swift
//  TechCareerFinalProject
//
//  Created by Ayşe Nur Kendirci on 19.09.2025.
//
import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var runShine = false
    @State private var glow = 0.0

    var body: some View {
        NavigationStack {
            ZStack {
                // Ana ekran
                MoviesScreen()
                    .opacity(showSplash ? 0 : 1)
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .move(edge: .trailing)),
                        removal: .opacity
                    ))

                if showSplash {
                    SplashWithShineAndGlow(
                        runShine: $runShine,
                        glow: $glow,
                        onFinished: {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showSplash = false
                            }
                        }
                    )
                    .transition(.opacity)
                }
            }
            .navigationDestination(for: Movie.self) { MovieDetailScreen(movie: $0) }
        }
    }
}

private struct SplashWithShineAndGlow: View {
    @Binding var runShine: Bool
    @Binding var glow: Double
    var onFinished: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            LottieView(
                name: "shopping",
                loopMode: .playOnce,
                contentMode: .scaleAspectFit,
                autoplay: true
            ) {
                withAnimation(.easeInOut(duration: 0.65)) { runShine = true }
                withAnimation(.easeInOut(duration: 0.35)) { glow = 1.0 }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    withAnimation(.easeOut(duration: 0.35)) { glow = 0.0 }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.70) {
                    onFinished()
                }
            }
            .padding(24)
            .overlay {
                RadialGradient(
                    colors: [
                        .white.opacity(0.0),
                        .white.opacity(0.0),
                        .white.opacity(0.35 * glow),
                        .white.opacity(0.0)
                    ],
                    center: .center,
                    startRadius: 10,
                    endRadius: 220
                )
                .blendMode(.screen)
                .allowsHitTesting(false)
            }
            if runShine {
                ShineSweep()
                    .allowsHitTesting(false)
            }
        }
    }
}
private struct ShineSweep: View {
    @State private var x: CGFloat = -1.2

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            Rectangle()
                .fill(
                    LinearGradient(
                        stops: [
                            .init(color: .white.opacity(0.0), location: 0.0),
                            .init(color: .white.opacity(0.18), location: 0.48),
                            .init(color: .white.opacity(0.0), location: 1.0)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: w * 0.28, height: h * 1.6)
                .rotationEffect(.degrees(20))
                // Ekranın sol dışında başlayıp sağ dışına kayıyor
                .offset(x: x * w, y: 0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.65)) {
                        x = 1.4
                    }
                }
        }
        .ignoresSafeArea()
        .blendMode(.screen) 
        .opacity(0.9)
    }
}

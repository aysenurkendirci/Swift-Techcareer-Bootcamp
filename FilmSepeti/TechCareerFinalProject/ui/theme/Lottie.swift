//
//  Lottie.swift
//  TechCareerFinalProject
//
//  Created by Ayşe Nur Kendirci on 27.09.2025.
//

import SwiftUI
import Lottie
import UIKit

struct LottieView: UIViewRepresentable {
    let name: String
    var loopMode: LottieLoopMode = .loop
    var speed: CGFloat = 1.0
    var contentMode: UIView.ContentMode = .scaleAspectFit
    var autoplay: Bool = true
    var onCompleted: (() -> Void)? = nil

    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        let animView = LottieAnimationView(name: name)
        animView.loopMode = loopMode
        animView.animationSpeed = speed
        animView.contentMode = contentMode
        animView.backgroundBehavior = .pauseAndRestore
        animView.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(animView)
        NSLayoutConstraint.activate([
            animView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            animView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            animView.topAnchor.constraint(equalTo: container.topAnchor),
            animView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        context.coordinator.animationView = animView
        if autoplay {
            animView.play { _ in onCompleted?() }
        }
        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let animView = context.coordinator.animationView else { return }
        animView.loopMode = loopMode
        animView.animationSpeed = speed
        animView.contentMode = contentMode
    }

    func makeCoordinator() -> Coordinator { Coordinator() }
    final class Coordinator { var animationView: LottieAnimationView? }
}

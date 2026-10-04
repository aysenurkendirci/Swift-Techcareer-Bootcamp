import SwiftUI

// Ölçüm için kullanılan tercih anahtarı
fileprivate struct RightWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 140
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
}
fileprivate struct MeasureWidth: View {
    var body: some View {
        GeometryReader { geo in
            Color.clear.preference(key: RightWidthKey.self, value: geo.size.width)
        }
    }
}

// Sadece sağ dış köşeleri yuvarlatan sarı şerit şekli
fileprivate struct RightRoundRect: Shape {
    let radius: CGFloat
    func path(in r: CGRect) -> Path {
        var p = Path()
        let rr = min(radius, min(r.width, r.height) / 2)
        p.move(to: .init(x: r.minX, y: r.minY))
        p.addLine(to: .init(x: r.maxX - rr, y: r.minY))
        p.addArc(center: .init(x: r.maxX - rr, y: r.minY + rr),
                 radius: rr, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        p.addLine(to: .init(x: r.maxX, y: r.maxY - rr))
        p.addArc(center: .init(x: r.maxX - rr, y: r.maxY - rr),
                 radius: rr, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        p.addLine(to: .init(x: r.minX, y: r.maxY))
        p.closeSubpath()
        return p
    }
}

// iOS 17 altı güvenli alan için
fileprivate func safeTopInset() -> CGFloat {
    let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
    for s in scenes {
        if let win = s.windows.first(where: { $0.isKeyWindow }) {
            return win.safeAreaInsets.top
        }
    }
    return 0
}

struct HeaderSection: View {
    private let barH: CGFloat = 44
    private let outerHPad: CGFloat = 16
    private let tvsHPad: CGFloat = 12

    @State private var tvsWidth: CGFloat = 140
    @State private var topInset: CGFloat = 0

    var body: some View {
        ZStack(alignment: .top) {
            // Mor arka plan
            AppColors.getirPurple
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // SADECE status bar kadar boşluk — ekstra padding yok
                Color.clear.frame(height: topInset)
                
                // Logo
                HStack {
                    Spacer()
                    Text("getir")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(AppColors.getirYellow)
                    Spacer()
                }
                .padding(.top, 4)
                
                // === EV / TVS BAR ===
                ZStack(alignment: .trailing) {
                    // Adres ve TVS'yi çevreleyen beyaz kapsül
                    Capsule()
                        .fill(Color.white)
                        .frame(height: barH)
                        .overlay(
                            HStack(spacing: 8) {
                                Text("Ev,").font(.subheadline.weight(.semibold))
                                    .foregroundStyle(AppColors.getirPurple)
                                Text("Cevizli, Kır Sk. 13 A, 34846 Maltepe…")
                                    .font(.subheadline.weight(.semibold))
                                    .lineLimit(1)
                                Image(systemName: "chevron.down")
                                    .font(.footnote).foregroundStyle(.secondary)
                            }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        )
                        .shadow(color: .black.opacity(0.06), radius: 10, y: 2)
                    
                    // Sarı TVS bölümü (beyaz kapsülün üstüne yerleşir)
                    HStack(spacing: 8) {
                        VStack(spacing: 0) {
                            Text("TVS").font(.caption2.weight(.semibold))
                            Text("45–60 dk").font(.subheadline.weight(.bold))
                        }
                        Image(systemName: "chevron.down")
                            .font(.footnote).foregroundStyle(.black.opacity(0.6))
                    }
                    .padding(.horizontal, 12)
                    .frame(height: barH)
                    .background(AppColors.getirYellow)
                    .clipShape(RightRoundRect(radius: barH / 2))
                    .shadow(color: .black.opacity(0.08), radius: 6, y: 2)
                    .fixedSize(horizontal: true, vertical: false)
                }
                .padding(.horizontal, outerHPad)
                .padding(.top, 8)
                
                // Alt beyaz ayraç
                Rectangle().fill(Color.white).frame(height: 1)
            }
        }
        .onAppear { topInset = safeTopInset() }
    }
}

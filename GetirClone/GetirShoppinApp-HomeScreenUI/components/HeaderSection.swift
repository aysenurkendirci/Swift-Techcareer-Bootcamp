import SwiftUI

fileprivate struct RightRoundRect: Shape {
    let radius: CGFloat
    func path(in r: CGRect) -> Path {
        var p = Path(); let rr = min(radius, min(r.width, r.height)/2)
        p.move(to: .init(x: r.minX, y: r.minY))
        p.addLine(to: .init(x: r.maxX - rr, y: r.minY))
        p.addArc(center: .init(x: r.maxX - rr, y: r.minY + rr),
                 radius: rr, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        p.addLine(to: .init(x: r.maxX, y: r.maxY - rr))
        p.addArc(center: .init(x: r.maxX - rr, y: r.maxY - rr),
                 radius: rr, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        p.addLine(to: .init(x: r.minX, y: r.maxY))
        p.closeSubpath(); return p
    }
}

fileprivate func topInset() -> CGFloat {
    UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .first?.keyWindow?.safeAreaInsets.top ?? 0
}

struct HeaderSection: View {
    private let stripH: CGFloat   = 44
    private let logoH: CGFloat    = 36
    private let logoGap: CGFloat  = 10
    private let hPad: CGFloat     = 14
    private let tvsHPad: CGFloat  = 14
    private let tvsMinW: CGFloat  = 132
    private let tvsBleed: CGFloat = 10

    var body: some View {
        let top = topInset()
        let headerH = top + logoH + logoGap + stripH
        let yellowW = tvsMinW + (tvsHPad * 2) + tvsBleed

        ZStack {
            AppColors.getirPurple
                .ignoresSafeArea(edges: .top)
                .frame(height: headerH)

            VStack(spacing: 0) {
                Spacer().frame(height: top)

                Image("logo")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .frame(height: logoH)
                    .accessibilityHidden(true)

                Spacer().frame(height: logoGap)

                ZStack(alignment: .trailing) {
                    Rectangle().fill(Color.white)
                    Rectangle().fill(AppColors.getirYellow)
                        .frame(width: yellowW)

                    RoundedRectangle(cornerRadius: stripH/2)
                        .fill(Color.white)
                        .frame(width: stripH, height: stripH)
                        .offset(x: -yellowW + stripH/2)
                }
                .frame(height: stripH)
                .overlay(alignment: .leading) {
                    HStack(spacing: 8) {
                        HStack(spacing: 6) {
                            Text("Ev,")
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(AppColors.getirPurple)

                            Text("Sancaktepe, Lale Sk. 13 A, 34846 Maltepe…")
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .minimumScaleFactor(0.95)
                        }

                        Image(systemName: "chevron.down")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 18)
                    .frame(height: stripH)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.06), radius: 6, y: 2)
                    .padding(.leading, hPad)
                    .padding(.trailing, yellowW + hPad)
                    .contentShape(Capsule())
                }
                .overlay(alignment: .trailing) {
                    HStack(spacing: 8) {
                        VStack(spacing: 0) {
                            Text("TVS").font(.caption.weight(.semibold))
                            Text("45–60 dk").font(.callout.weight(.bold))
                        }
                        Image(systemName: "chevron.down")
                            .font(.footnote)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                    .padding(.horizontal, tvsHPad)
                    .frame(height: stripH)
                    .frame(minWidth: tvsMinW)
                    .background(AppColors.getirYellow)
                    .clipShape(RightRoundRect(radius: stripH/2))
                    .shadow(color: .black.opacity(0.08), radius: 6, y: 2)
                    .padding(.trailing, hPad)
                }
            }
            .frame(height: headerH, alignment: .bottom)
        }
    }
}

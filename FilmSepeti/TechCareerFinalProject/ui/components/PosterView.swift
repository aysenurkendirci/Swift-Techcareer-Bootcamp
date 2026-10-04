import SwiftUI

struct PosterView: View {
    private let posterFilename: String

    init(path: String) { self.posterFilename = path }

    init(posterFilename: String) { self.posterFilename = posterFilename }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(.ultraThinMaterial)

            AsyncImage(url: MoviesRepository.imageURL(for: posterFilename)) { phase in
                switch phase {
                case .empty:
                    ProgressView().scaleEffect(0.9)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .accessibilityLabel(Text("Poster: \(posterFilename)"))

                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .padding(24)
                        .foregroundStyle(.secondary)

                @unknown default:
                    Color.clear
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 14))
        }
        .aspectRatio(2/3, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

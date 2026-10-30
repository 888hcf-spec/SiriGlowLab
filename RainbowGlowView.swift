import SwiftUI

struct RainbowGlowView: View {
    var intensity: Double = 0.85
    var speed: Double = 0.65
    @State private var rotation: Double = 0
    private let colors: [Color] = [
        Color(red: 1, green: 0.16, blue: 0.48),
        Color(red: 0.68, green: 0.22, blue: 1),
        Color(red: 0.20, green: 0.38, blue: 1),
        Color(red: 0.08, green: 0.82, blue: 1),
        Color(red: 0.12, green: 1, blue: 0.65),
        Color(red: 1, green: 0.88, blue: 0.18),
        Color(red: 1, green: 0.38, blue: 0.12),
        Color(red: 1, green: 0.16, blue: 0.48)
    ]

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black
                RoundedRectangle(cornerRadius: 42, style: .continuous)
                    .stroke(AngularGradient(colors: colors, center: .center, angle: .degrees(rotation)), lineWidth: 9)
                    .padding(5).blur(radius: 22).opacity(0.95 * intensity)
                RoundedRectangle(cornerRadius: 42, style: .continuous)
                    .stroke(AngularGradient(colors: colors, center: .center, angle: .degrees(rotation)), lineWidth: 4)
                    .padding(5).blur(radius: 8).opacity(0.95 * intensity)
                RoundedRectangle(cornerRadius: 42, style: .continuous)
                    .stroke(AngularGradient(colors: colors, center: .center, angle: .degrees(rotation)), lineWidth: 2)
                    .padding(5).opacity(intensity)
                VStack(spacing: 12) {
                    Image(systemName: "sparkles").font(.system(size: 27, weight: .light)).foregroundStyle(.white.opacity(0.75))
                    Text("SiriGlowLab").font(.system(size: 20, weight: .semibold)).foregroundStyle(.white.opacity(0.82))
                    Text("RAINBOW LIGHT EXPERIENCE").font(.system(size: 9, weight: .medium)).tracking(2).foregroundStyle(.white.opacity(0.35))
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .clipped()
            .onAppear {
                withAnimation(.linear(duration: max(3, 18 * (1.1 - speed))).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
        }.background(.black)
    }
}

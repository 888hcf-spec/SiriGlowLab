import SwiftUI

struct RainbowGlowView: View {
    @State private var animate = false

    private let rainbow: [Color] = [
        .red, .orange, .yellow, .green,
        .cyan, .blue, .purple, .pink, .red
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .ignoresSafeArea()

                RoundedRectangle(cornerRadius: 38)
                    .strokeBorder(
                        AngularGradient(
                            colors: rainbow,
                            center: .center,
                            startAngle: .degrees(animate ? 360 : 0),
                            endAngle: .degrees(animate ? 720 : 360)
                        ),
                        lineWidth: 4
                    )
                    .frame(
                        width: geometry.size.width + 70,
                        height: geometry.size.height + 70
                    )
                    .blur(radius: 7)
                    .opacity(0.95)

                RoundedRectangle(cornerRadius: 38)
                    .strokeBorder(
                        AngularGradient(
                            colors: rainbow,
                            center: .center,
                            startAngle: .degrees(animate ? 0 : 360),
                            endAngle: .degrees(animate ? 360 : 720)
                        ),
                        lineWidth: 2
                    )
                    .frame(
                        width: geometry.size.width + 70,
                        height: geometry.size.height + 70
                    )
                    .blur(radius: 2)
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
            .clipped()
            .ignoresSafeArea()
            .onAppear {
                withAnimation(
                    .linear(duration: 6)
                        .repeatForever(autoreverses: false)
                ) {
                    animate = true
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RainbowGlowView()
}
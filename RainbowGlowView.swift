import SwiftUI

struct RainbowGlowView: View {
@State private var animate = false

var body: some View {
    ZStack {
        Color.black
            .ignoresSafeArea()
        RoundedRectangle(cornerRadius: 42)
            .strokeBorder(
                AngularGradient(
                    colors: [
                        .red, .orange, .yellow,
                        .green, .cyan, .blue,
                        .purple, .pink, .red
                    ],
                    center: .center,
                    startAngle: .degrees(animate ? 360 : 0),
                    endAngle: .degrees(animate ? 720 : 360)
                ),
                lineWidth: 9
            )
            .blur(radius: 13)
            .padding(5)
            .opacity(0.95)
            .animation(
                .linear(duration: 5)
                    .repeatForever(autoreverses: false),
                value: animate
            )
    }
    .onAppear {
        animate = true
    }
}

}

#Preview {
RainbowGlowView()
}

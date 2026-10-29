
import SwiftUI

struct ContentView: View {
    @State private var previewEnabled = false
    @State private var orbRotates = false

    private var systemVersion: String {
        let v = ProcessInfo.processInfo.operatingSystemVersion
        return "\(v.majorVersion).\(v.minorVersion).\(v.patchVersion)"
    }

    var body: some View {
        ZStack {
            Color(red: 0.018, green: 0.022, blue: 0.045)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 26) {
                    header
                    hero
                    previewButton
                    featureSection
                    deviceSection
                    footer
                }
                .padding(.horizontal, 22)
                .padding(.top, 18)
                .padding(.bottom, 34)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            withAnimation(
                .linear(duration: 12)
                .repeatForever(autoreverses: false)
            ) {
                orbRotates = true
            }
        }
        .fullScreenCover(isPresented: $previewEnabled) {
            RainbowPreviewScreen {
                previewEnabled = false
            }
        }
    }

    private var header: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 17)
                    .fill(Color.white.opacity(0.07))

                RainbowOrb(size: 42, rotating: orbRotates)
                    .padding(7)
            }
            .frame(width: 58, height: 58)

            VStack(alignment: .leading, spacing: 4) {
                Text("SiriGlowLab")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)

                Text("RAINBOW LIGHT STUDIO")
                    .font(.system(size: 9, weight: .bold))
                    .tracking(2)
                    .foregroundStyle(.white.opacity(0.42))
            }

            Spacer()

            HStack(spacing: 6) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 6, height: 6)

                Text("READY")
                    .font(.system(size: 9, weight: .bold))
                    .tracking(1)
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.06), in: Capsule())
        }
    }

    private var hero: some View {
        VStack(spacing: 18) {
            ZStack {
                Circle()
                    .fill(Color.purple.opacity(0.15))
                    .frame(width: 230, height: 230)
                    .blur(radius: 48)

                Circle()
                    .fill(Color.blue.opacity(0.12))
                    .frame(width: 170, height: 170)
                    .blur(radius: 35)
                    .offset(x: 36, y: 25)

                RainbowOrb(size: 176, rotating: orbRotates)
                    .shadow(color: .purple.opacity(0.24), radius: 35)
            }
            .frame(height: 220)

            VStack(spacing: 9) {
                Text("让色彩，随光流动。")
                    .font(.system(size: 29, weight: .bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                Text("探索灵感来自 Siri 的彩虹光效，\n打造属于你的沉浸式视觉体验。")
                    .font(.system(size: 14))
                    .foregroundStyle(.white.opacity(0.55))
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 2)
    }

    private var previewButton: some View {
        Button {
            previewEnabled = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "sparkles")
                    .font(.system(size: 17, weight: .semibold))

                Text("开启全屏光效")
                    .font(.system(size: 16, weight: .semibold))

                Spacer()

                Image(systemName: "arrow.up.right")
                    .font(.system(size: 14, weight: .bold))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .frame(height: 58)
            .background {
                RoundedRectangle(cornerRadius: 19)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.53, green: 0.28, blue: 0.98),
                                Color(red: 0.28, green: 0.38, blue: 0.98),
                                Color(red: 0.12, green: 0.62, blue: 0.91)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
            .overlay {
                RoundedRectangle(cornerRadius: 19)
                    .stroke(Color.white.opacity(0.18), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }

    private var featureSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionHeading("体验亮点", subtitle: "MADE FOR YOUR SCREEN")

            HStack(spacing: 12) {
                featureCard(
                    icon: "paintpalette.fill",
                    title: "彩虹色彩",
                    subtitle: "多色渐变光环",
                    tint: .purple
                )

                featureCard(
                    icon: "waveform",
                    title: "流动视觉",
                    subtitle: "动态旋转效果",
                    tint: .cyan
                )
            }

            HStack(spacing: 12) {
                featureCard(
                    icon: "viewfinder",
                    title: "全屏预览",
                    subtitle: "沉浸式展示",
                    tint: .pink
                )

                featureCard(
                    icon: "hand.tap.fill",
                    title: "轻松操作",
                    subtitle: "一键进入体验",
                    tint: .orange
                )
            }
        }
    }

    private var deviceSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeading("设备与功能", subtitle: "DEVICE STATUS")

            VStack(spacing: 0) {
                statusRow(
                    icon: "iphone",
                    title: "当前系统",
                    value: "iOS \(systemVersion)",
                    tint: .cyan
                )

                Divider()
                    .overlay(Color.white.opacity(0.07))
                    .padding(.leading, 42)

                statusRow(
                    icon: "sparkles",
                    title: "App 内彩虹预览",
                    value: "可体验",
                    tint: .green
                )

                Divider()
                    .overlay(Color.white.opacity(0.07))
                    .padding(.leading, 42)

                statusRow(
                    icon: "waveform",
                    title: "系统 Siri 光效",
                    value: "尚未实现",
                    tint: .orange
                )
            }
            .padding(.horizontal, 16)
            .background(Color.white.opacity(0.045))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .overlay {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.white.opacity(0.07), lineWidth: 1)
            }

            Text("当前版本提供 App 内视觉预览，不会修改系统 Siri 的界面。")
                .font(.system(size: 11))
                .foregroundStyle(.white.opacity(0.4))
                .lineSpacing(4)
        }
    }

    private var footer: some View {
        VStack(spacing: 8) {
            RainbowOrb(size: 25, rotating: orbRotates)

            Text("SIRIGLOWLAB")
                .font(.system(size: 9, weight: .bold))
                .tracking(2.5)
                .foregroundStyle(.white.opacity(0.35))

            Text("A little more color in your world.")
                .font(.system(size: 11))
                .foregroundStyle(.white.opacity(0.28))
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 5)
    }

    private func sectionHeading(
        _ title: String,
        subtitle: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)

            Text(subtitle)
                .font(.system(size: 9, weight: .bold))
                .tracking(1.8)
                .foregroundStyle(.white.opacity(0.35))
        }
    }

    private func featureCard(
        icon: String,
        title: String,
        subtitle: String,
        tint: Color
    ) -> some View {
        VStack(alignment: .leading, spacing: 13) {
            Image(systemName: icon)
                .font(.system(size: 19, weight: .semibold))
                .foregroundStyle(tint)
                .frame(width: 40, height: 40)
                .background(tint.opacity(0.13), in: RoundedRectangle(cornerRadius: 13))

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)

                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundStyle(.white.opacity(0.45))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background(Color.white.opacity(0.045))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        }
    }

    private func statusRow(
        icon: String,
        title: String,
        value: String,
        tint: Color
    ) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(tint)
                .frame(width: 26)

            Text(title)
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.76))

            Spacer()

            Text(value)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(tint)
        }
        .padding(.vertical, 16)
    }
}

private struct RainbowOrb: View {
    let size: CGFloat
    let rotating: Bool

    private let colors: [Color] = [
        .pink, .purple, .blue, .cyan,
        .green, .yellow, .orange, .pink
    ]

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white.opacity(0.16),
                            Color.purple.opacity(0.12),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 2,
                        endRadius: size * 0.55
                    )
                )

            Circle()
                .stroke(
                    AngularGradient(
                        colors: colors,
                        center: .center
                    ),
                    lineWidth: max(3, size * 0.055)
                )
                .padding(size * 0.055)
                .blur(radius: size * 0.035)
                .opacity(0.9)

            Circle()
                .stroke(
                    AngularGradient(
                        colors: colors,
                        center: .center
                    ),
                    lineWidth: max(1.5, size * 0.018)
                )
                .padding(size * 0.09)

            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white.opacity(0.22),
                            Color.blue.opacity(0.13),
                            Color.black.opacity(0.65)
                        ],
                        center: .topLeading,
                        startRadius: 1,
                        endRadius: size * 0.8
                    )
                )
                .padding(size * 0.15)

            Circle()
                .stroke(Color.white.opacity(0.18), lineWidth: 1)
                .padding(size * 0.15)

            Circle()
                .fill(
                    AngularGradient(
                        colors: colors.map { $0.opacity(0.35) },
                        center: .center
                    )
                )
                .frame(width: size * 0.18, height: size * 0.18)
                .blur(radius: size * 0.08)
                .offset(x: -size * 0.12, y: -size * 0.13)
        }
        .frame(width: size, height: size)
        .rotationEffect(.degrees(rotating ? 360 : 0))
        .animation(
            .linear(duration: 12).repeatForever(autoreverses: false),
            value: rotating
        )
    }
}

private struct RainbowPreviewScreen: View {
    let close: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RainbowGlowView()
                .ignoresSafeArea()

            VStack {
                Button(action: close) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 46, height: 46)
                        .background(.ultraThinMaterial, in: Circle())
                        .overlay {
                            Circle()
                                .stroke(
                                    Color.white.opacity(0.18),
                                    lineWidth: 1
                                )
                        }
                }
                .accessibilityLabel("关闭预览")
                .padding(.top, 12)
                .padding(.trailing, 16)

                Spacer()

                Text("RAINBOW PREVIEW")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(2.5)
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.bottom, 28)
            }
        }
        .background(Color.black)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

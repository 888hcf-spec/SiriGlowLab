
import SwiftUI

struct ContentView: View {
    @State private var previewEnabled = false

    private var systemVersion: String {
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
    }

    var body: some View {
        ZStack {
            Color(red: 0.025, green: 0.025, blue: 0.05)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 26) {
                    header
                    heroCard
                    controlCard
                    compatibilityCard
                    footer
                }
                .padding(.horizontal, 22)
                .padding(.top, 24)
                .padding(.bottom, 36)
            }
        }
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $previewEnabled) {
            RainbowPreviewScreen {
                previewEnabled = false
            }
        }
    }

    private var header: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white.opacity(0.07))
                    .frame(width: 58, height: 58)

                Image(systemName: "waveform")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.pink, .purple, .blue, .cyan],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }

            VStack(alignment: .leading, spacing: 5) {
                Text("SiriGlowLab")
                    .font(.title2.bold())
                    .foregroundStyle(.white)

                Text("RAINBOW EXPERIENCE")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(2)
                    .foregroundStyle(.white.opacity(0.45))
            }

            Spacer()

            Circle()
                .fill(Color.green)
                .frame(width: 7, height: 7)
                .shadow(color: .green.opacity(0.7), radius: 7)
        }
    }

    private var heroCard: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.24, green: 0.10, blue: 0.42),
                            Color(red: 0.09, green: 0.10, blue: 0.25),
                            Color(red: 0.04, green: 0.04, blue: 0.10)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Circle()
                .fill(Color.purple.opacity(0.25))
                .frame(width: 180, height: 180)
                .blur(radius: 55)
                .offset(x: 180, y: -70)

            VStack(alignment: .leading, spacing: 18) {
                ZStack {
                    RoundedRectangle(cornerRadius: 23)
                        .stroke(
                            AngularGradient(
                                colors: [
                                    .pink, .purple, .blue,
                                    .cyan, .green, .yellow, .pink
                                ],
                                center: .center
                            ),
                            lineWidth: 3
                        )
                        .frame(width: 92, height: 92)
                        .shadow(color: .purple.opacity(0.6), radius: 15)

                    Image(systemName: "sparkles")
                        .font(.system(size: 38, weight: .light))
                        .foregroundStyle(.white)
                }
                .padding(.top, 26)

                VStack(alignment: .leading, spacing: 8) {
                    Text("让光效，流动起来。")
                        .font(.system(size: 27, weight: .bold))
                        .foregroundStyle(.white)

                    Text("探索绚丽的彩虹边缘动画，打造专属于你的视觉体验。")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.68))
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Button {
                    previewEnabled = true
                } label: {
                    HStack(spacing: 9) {
                        Image(systemName: "play.fill")
                        Text("体验全屏光效")
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "arrow.up.right")
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 18)
                    .frame(height: 52)
                    .background(
                        LinearGradient(
                            colors: [.purple, .blue.opacity(0.85)],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        in: RoundedRectangle(cornerRadius: 17)
                    )
                }
                .buttonStyle(.plain)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private var controlCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            sectionTitle("光效控制", subtitle: "LIGHT EFFECT")

            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.purple.opacity(0.18))
                        .frame(width: 50, height: 50)

                    Image(systemName: "rainbow")
                        .font(.system(size: 25))
                        .foregroundStyle(.purple)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("彩虹光效预览")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)

                    Text(previewEnabled ? "预览已开启" : "控制 App 内的视觉效果")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                }

                Spacer()

                Toggle("彩虹光效", isOn: $previewEnabled)
                    .labelsHidden()
                    .tint(.purple)
                    .fixedSize()
                    .accessibilityLabel("开启彩虹光效预览")
            }

            Text("提示：开启开关会进入全屏预览；关闭预览即可返回主界面。")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.45))
                .lineSpacing(3)
        }
        .padding(20)
        .background(Color.white.opacity(0.045))
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.07), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var compatibilityCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            sectionTitle("设备与兼容性", subtitle: "DEVICE STATUS")

            statusRow(
                icon: "iphone",
                title: "当前系统",
                value: "iOS \(systemVersion)",
                color: .cyan
            )

            Divider().overlay(Color.white.opacity(0.08))

            statusRow(
                icon: "sparkles",
                title: "App 内彩虹预览",
                value: "已集成",
                color: .green
            )

            Divider().overlay(Color.white.opacity(0.08))

            statusRow(
                icon: "waveform",
                title: "系统 Siri 彩虹效果",
                value: "尚未验证",
                color: .orange
            )

            Text("系统 Siri 的外观受 iOS 系统权限与版本限制。本 App 目前不会修改系统 Siri。")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.48))
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(20)
        .background(Color.white.opacity(0.045))
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.07), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var footer: some View {
        HStack {
            Spacer()
            Image(systemName: "sparkle")
            Text("MADE FOR YOUR OWN EXPERIENCE")
                .tracking(1.5)
            Spacer()
        }
        .font(.system(size: 9, weight: .medium))
        .foregroundStyle(.white.opacity(0.28))
        .padding(.top, 2)
    }

    private func sectionTitle(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)

            Text(subtitle)
                .font(.system(size: 9, weight: .bold))
                .tracking(1.8)
                .foregroundStyle(.white.opacity(0.35))
        }
    }

    private func statusRow(
        icon: String,
        title: String,
        value: String,
        color: Color
    ) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 17))
                .foregroundStyle(color)
                .frame(width: 25)

            Text(title)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.75))

            Spacer()

            Text(value)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(color)
                .multilineTextAlignment(.trailing)
        }
    }
}

private struct RainbowPreviewScreen: View {
    let close: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RainbowGlowView()
                .ignoresSafeArea()

            Button(action: close) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .padding(.top, 12)
            .padding(.trailing, 16)
            .accessibilityLabel("关闭预览")
        }
        .background(Color.black)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

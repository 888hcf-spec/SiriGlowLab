import SwiftUI

struct ContentView: View {
    @State private var showPreview = false
    @State private var showSettings = false
    @State private var intensity = 0.85
    @State private var speed = 0.65
    @State private var enabled = true

    private var version: String {
        let v = ProcessInfo.processInfo.operatingSystemVersion
        return "\(v.majorVersion).\(v.minorVersion).\(v.patchVersion)"
    }

    var body: some View {
        ZStack {
            Color(red: 0.018, green: 0.022, blue: 0.045).ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    header
                    hero
                    Button { showPreview = true } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "sparkles")
                            Text("开启全屏光效").fontWeight(.semibold)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                        }
                        .font(.system(size: 16)).foregroundStyle(.white)
                        .padding(.horizontal, 20).frame(height: 58)
                        .background(LinearGradient(colors: [
                            Color(red: 0.56, green: 0.25, blue: 0.98),
                            Color(red: 0.27, green: 0.37, blue: 0.98),
                            Color(red: 0.10, green: 0.62, blue: 0.91)
                        ], startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 19))
                    }.buttonStyle(.plain)
                    featureGrid
                    settingsCard
                    deviceCard
                    footer
                }.padding(.horizontal, 22).padding(.top, 18).padding(.bottom, 36)
            }
        }
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $showPreview) {
            RainbowPreviewScreen(intensity: enabled ? intensity : 0, speed: speed) { showPreview = false }
        }
        .sheet(isPresented: $showSettings) {
            GlowSettingsSheet(intensity: $intensity, speed: $speed, enabled: $enabled)
                .presentationDetents([.medium, .large]).presentationDragIndicator(.visible)
        }
    }

    private var header: some View {
        HStack(spacing: 12) {
            RainbowOrb(size: 48).frame(width: 58, height: 58)
                .background(.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 17))
            VStack(alignment: .leading, spacing: 4) {
                Text("SiriGlowLab").font(.system(size: 22, weight: .bold)).foregroundStyle(.white)
                Text("RAINBOW LIGHT STUDIO").font(.system(size: 9, weight: .bold)).tracking(2).foregroundStyle(.white.opacity(0.42))
            }
            Spacer()
            HStack(spacing: 6) {
                Circle().fill(.green).frame(width: 6, height: 6)
                Text("READY").font(.system(size: 9, weight: .bold)).tracking(1).foregroundStyle(.white.opacity(0.7))
            }.padding(.horizontal, 10).padding(.vertical, 8).background(.white.opacity(0.06), in: Capsule())
        }
    }

    private var hero: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle().fill(.purple.opacity(0.17)).frame(width: 220, height: 220).blur(radius: 48)
                Circle().fill(.blue.opacity(0.13)).frame(width: 165, height: 165).blur(radius: 38).offset(x: 35, y: 25)
                RainbowOrb(size: 174).shadow(color: .purple.opacity(0.3), radius: 30)
            }.frame(height: 220)
            Text("让色彩，随光流动。").font(.system(size: 28, weight: .bold)).foregroundStyle(.white)
            Text("探索灵感来自 Siri 的彩虹光效，\n打造属于你的沉浸式视觉体验。")
                .font(.system(size: 14)).foregroundStyle(.white.opacity(0.55)).multilineTextAlignment(.center).lineSpacing(5)
        }.padding(.top, 8)
    }

    private var featureGrid: some View {
        VStack(alignment: .leading, spacing: 13) {
            sectionTitle("体验亮点", "MADE FOR YOUR SCREEN")
            HStack(spacing: 12) {
                featureCard("paintpalette.fill", "彩虹色彩", "多色渐变光环", .purple)
                featureCard("waveform", "流动视觉", "动态旋转效果", .cyan)
            }
            HStack(spacing: 12) {
                featureCard("viewfinder", "全屏预览", "沉浸式展示", .pink)
                featureCard("slider.horizontal.3", "光效设置", "亮度与速度调整", .orange)
            }
        }
    }

    private var settingsCard: some View {
        Button { showSettings = true } label: {
            HStack(spacing: 13) {
                Image(systemName: "slider.horizontal.3").font(.system(size: 18, weight: .semibold)).foregroundStyle(.cyan)
                    .frame(width: 42, height: 42).background(.cyan.opacity(0.13), in: RoundedRectangle(cornerRadius: 13))
                VStack(alignment: .leading, spacing: 4) {
                    Text("光效设置").font(.system(size: 15, weight: .semibold)).foregroundStyle(.white)
                    Text("调整亮度、动画速度与效果开关").font(.system(size: 11)).foregroundStyle(.white.opacity(0.45))
                }
                Spacer()
                Image(systemName: "chevron.right").foregroundStyle(.white.opacity(0.4))
            }.padding(15).background(.white.opacity(0.045), in: RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.07), lineWidth: 1))
        }.buttonStyle(.plain)
    }

    private var deviceCard: some View {
        VStack(alignment: .leading, spacing: 13) {
            sectionTitle("设备与功能", "DEVICE STATUS")
            VStack(spacing: 0) {
                statusRow("iphone", "当前系统", "iOS \(version)", .cyan)
                Divider().overlay(.white.opacity(0.07)).padding(.leading, 42)
                statusRow("sparkles", "App 内彩虹预览", "可体验", .green)
                Divider().overlay(.white.opacity(0.07)).padding(.leading, 42)
                statusRow("waveform", "系统 Siri 光效", "尚未实现", .orange)
            }.padding(.horizontal, 16).background(.white.opacity(0.045), in: RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.07), lineWidth: 1))
            Text("当前版本提供 App 内视觉预览，不会修改系统 Siri 的界面。")
                .font(.system(size: 11)).foregroundStyle(.white.opacity(0.4))
        }
    }

    private var footer: some View {
        VStack(spacing: 7) {
            RainbowOrb(size: 25)
            Text("SIRIGLOWLAB").font(.system(size: 9, weight: .bold)).tracking(2.5).foregroundStyle(.white.opacity(0.35))
            Text("A little more color in your world.").font(.system(size: 11)).foregroundStyle(.white.opacity(0.28))
        }.frame(maxWidth: .infinity).padding(.top, 3)
    }

    private func sectionTitle(_ title: String, _ subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).font(.system(size: 18, weight: .bold)).foregroundStyle(.white)
            Text(subtitle).font(.system(size: 9, weight: .bold)).tracking(1.8).foregroundStyle(.white.opacity(0.35))
        }.frame(maxWidth: .infinity, alignment: .leading)
    }

    private func featureCard(_ icon: String, _ title: String, _ subtitle: String, _ tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon).font(.system(size: 18, weight: .semibold)).foregroundStyle(tint)
                .frame(width: 40, height: 40).background(tint.opacity(0.13), in: RoundedRectangle(cornerRadius: 13))
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.system(size: 14, weight: .semibold)).foregroundStyle(.white)
                Text(subtitle).font(.system(size: 11)).foregroundStyle(.white.opacity(0.45))
            }
        }.frame(maxWidth: .infinity, alignment: .leading).padding(15)
            .background(.white.opacity(0.045), in: RoundedRectangle(cornerRadius: 19))
            .overlay(RoundedRectangle(cornerRadius: 19).stroke(.white.opacity(0.06), lineWidth: 1))
    }

    private func statusRow(_ icon: String, _ title: String, _ value: String, _ tint: Color) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon).font(.system(size: 16)).foregroundStyle(tint).frame(width: 26)
            Text(title).font(.system(size: 13)).foregroundStyle(.white.opacity(0.76))
            Spacer()
            Text(value).font(.system(size: 12, weight: .medium)).foregroundStyle(tint)
        }.padding(.vertical, 15)
    }
}

private struct GlowSettingsSheet: View {
    @Binding var intensity: Double
    @Binding var speed: Double
    @Binding var enabled: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section("光效控制") {
                    Toggle("启用彩虹光效", isOn: $enabled)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack { Text("光效亮度"); Spacer(); Text("\(Int(intensity * 100))%").foregroundStyle(.secondary) }
                        Slider(value: $intensity, in: 0.1...1)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        HStack { Text("动画速度"); Spacer(); Text("\(Int(speed * 100))%").foregroundStyle(.secondary) }
                        Slider(value: $speed, in: 0.1...1)
                    }
                }
                Section {
                    Text("这些设置只影响 SiriGlowLab 内的预览效果，不会更改 iOS 系统 Siri。").font(.footnote).foregroundStyle(.secondary)
                }
            }.navigationTitle("光效设置").navigationBarTitleDisplayMode(.inline)
        }.preferredColorScheme(.dark)
    }
}

private struct RainbowOrb: View {
    let size: CGFloat
    @State private var spin = false
    private let colors: [Color] = [.pink, .purple, .blue, .cyan, .green, .yellow, .orange, .pink]

    var body: some View {
        ZStack {
            Circle().fill(RadialGradient(colors: [.white.opacity(0.17), .purple.opacity(0.12), .clear], center: .center, startRadius: 1, endRadius: size * 0.55))
            Circle().stroke(AngularGradient(colors: colors, center: .center), lineWidth: max(3, size * 0.055))
                .padding(size * 0.055).blur(radius: size * 0.035).opacity(0.9)
            Circle().stroke(AngularGradient(colors: colors, center: .center), lineWidth: max(1.5, size * 0.018)).padding(size * 0.09)
            Circle().fill(RadialGradient(colors: [.white.opacity(0.2), .blue.opacity(0.12), .black.opacity(0.7)], center: .topLeading, startRadius: 1, endRadius: size * 0.8)).padding(size * 0.15)
            Circle().stroke(.white.opacity(0.18), lineWidth: 1).padding(size * 0.15)
            Circle().fill(AngularGradient(colors: colors.map { $0.opacity(0.35) }, center: .center))
                .frame(width: size * 0.2, height: size * 0.2).blur(radius: size * 0.08).offset(x: -size * 0.12, y: -size * 0.13)
        }.frame(width: size, height: size).rotationEffect(.degrees(spin ? 360 : 0))
            .onAppear { withAnimation(.linear(duration: 14).repeatForever(autoreverses: false)) { spin = true } }
    }
}

private struct RainbowPreviewScreen: View {
    let intensity: Double
    let speed: Double
    let close: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            RainbowGlowView(intensity: intensity, speed: speed).ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Button(action: close) {
                        Image(systemName: "xmark").font(.system(size: 16, weight: .bold)).foregroundStyle(.white)
                            .frame(width: 46, height: 46).background(.ultraThinMaterial, in: Circle())
                            .overlay(Circle().stroke(.white.opacity(0.18), lineWidth: 1))
                    }.accessibilityLabel("关闭预览")
                }.padding(.top, 12).padding(.trailing, 16)
                Spacer()
                Text("RAINBOW PREVIEW").font(.system(size: 10, weight: .bold)).tracking(2.5)
                    .foregroundStyle(.white.opacity(0.45)).padding(.bottom, 28)
            }
        }.preferredColorScheme(.dark)
    }
}

#Preview { ContentView() }

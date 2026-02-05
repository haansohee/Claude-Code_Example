import SwiftUI

struct CatShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        // 몸통 (타원)
        path.addEllipse(in: CGRect(x: w * 0.15, y: h * 0.4, width: w * 0.7, height: h * 0.5))

        // 머리 (원)
        path.addEllipse(in: CGRect(x: w * 0.25, y: h * 0.1, width: w * 0.5, height: h * 0.4))

        // 왼쪽 귀
        path.move(to: CGPoint(x: w * 0.28, y: h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.18, y: h * 0.0))
        path.addLine(to: CGPoint(x: w * 0.38, y: h * 0.15))
        path.closeSubpath()

        // 오른쪽 귀
        path.move(to: CGPoint(x: w * 0.72, y: h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.82, y: h * 0.0))
        path.addLine(to: CGPoint(x: w * 0.62, y: h * 0.15))
        path.closeSubpath()

        // 꼬리
        path.move(to: CGPoint(x: w * 0.85, y: h * 0.6))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.95, y: h * 0.3),
            control: CGPoint(x: w * 1.1, y: h * 0.5)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.85, y: h * 0.65),
            control: CGPoint(x: w * 1.0, y: h * 0.4)
        )

        return path
    }
}

struct CatFace: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            ZStack {
                // 왼쪽 눈
                Ellipse()
                    .fill(.black)
                    .frame(width: w * 0.12, height: w * 0.15)
                    .position(x: w * 0.38, y: h * 0.28)

                // 오른쪽 눈
                Ellipse()
                    .fill(.black)
                    .frame(width: w * 0.12, height: w * 0.15)
                    .position(x: w * 0.62, y: h * 0.28)

                // 눈 하이라이트 (왼쪽)
                Circle()
                    .fill(.white)
                    .frame(width: w * 0.04, height: w * 0.04)
                    .position(x: w * 0.36, y: h * 0.26)

                // 눈 하이라이트 (오른쪽)
                Circle()
                    .fill(.white)
                    .frame(width: w * 0.04, height: w * 0.04)
                    .position(x: w * 0.60, y: h * 0.26)

                // 코
                Circle()
                    .fill(.pink)
                    .frame(width: w * 0.08, height: w * 0.06)
                    .position(x: w * 0.5, y: h * 0.36)

                // 입 (왼쪽)
                Path { path in
                    path.move(to: CGPoint(x: w * 0.5, y: h * 0.38))
                    path.addQuadCurve(
                        to: CGPoint(x: w * 0.38, y: h * 0.42),
                        control: CGPoint(x: w * 0.44, y: h * 0.44)
                    )
                }
                .stroke(.black, lineWidth: 2)

                // 입 (오른쪽)
                Path { path in
                    path.move(to: CGPoint(x: w * 0.5, y: h * 0.38))
                    path.addQuadCurve(
                        to: CGPoint(x: w * 0.62, y: h * 0.42),
                        control: CGPoint(x: w * 0.56, y: h * 0.44)
                    )
                }
                .stroke(.black, lineWidth: 2)

                // 수염 (왼쪽)
                ForEach(0..<3) { i in
                    Path { path in
                        let startY = h * (0.32 + Double(i) * 0.04)
                        path.move(to: CGPoint(x: w * 0.32, y: startY))
                        path.addLine(to: CGPoint(x: w * 0.12, y: startY - 0.02 * h + Double(i) * 0.02 * h))
                    }
                    .stroke(.gray, lineWidth: 1.5)
                }

                // 수염 (오른쪽)
                ForEach(0..<3) { i in
                    Path { path in
                        let startY = h * (0.32 + Double(i) * 0.04)
                        path.move(to: CGPoint(x: w * 0.68, y: startY))
                        path.addLine(to: CGPoint(x: w * 0.88, y: startY - 0.02 * h + Double(i) * 0.02 * h))
                    }
                    .stroke(.gray, lineWidth: 1.5)
                }
            }
        }
    }
}

struct DancingCatView: View {
    @Binding var isAnimating: Bool
    @State private var rotation: Double = 0
    @State private var yOffset: CGFloat = 0
    @State private var scale: CGFloat = 1.0
    @State private var wobble: Double = 0

    let catColor: Color

    init(isAnimating: Binding<Bool>, catColor: Color = .orange) {
        self._isAnimating = isAnimating
        self.catColor = catColor
    }

    var body: some View {
        ZStack {
            // 고양이 몸체
            CatShape()
                .fill(catColor)

            CatShape()
                .stroke(.black, lineWidth: 3)

            // 고양이 얼굴
            CatFace()
        }
        .frame(width: 200, height: 200)
        .scaleEffect(scale)
        .offset(y: yOffset)
        .rotationEffect(.degrees(wobble))
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        .onChange(of: isAnimating) { _, newValue in
            if newValue {
                startAnimations()
            } else {
                stopAnimations()
            }
        }
        .onAppear {
            if isAnimating {
                startAnimations()
            }
        }
    }

    private func startAnimations() {
        // 점프 애니메이션
        withAnimation(
            .easeInOut(duration: 0.4)
            .repeatForever(autoreverses: true)
        ) {
            yOffset = -30
        }

        // 크기 변화
        withAnimation(
            .easeInOut(duration: 0.3)
            .repeatForever(autoreverses: true)
        ) {
            scale = 1.1
        }

        // 좌우 흔들기
        withAnimation(
            .easeInOut(duration: 0.2)
            .repeatForever(autoreverses: true)
        ) {
            wobble = 10
        }

        // 회전
        withAnimation(
            .linear(duration: 2)
            .repeatForever(autoreverses: false)
        ) {
            rotation = 360
        }
    }

    private func stopAnimations() {
        withAnimation(.easeOut(duration: 0.3)) {
            yOffset = 0
            scale = 1.0
            wobble = 0
            rotation = 0
        }
    }
}

#Preview {
    DancingCatView(isAnimating: .constant(true))
}

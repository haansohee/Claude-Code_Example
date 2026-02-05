import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    @State private var selectedColor: Color = .orange
    @State private var showColorPicker = false

    let catColors: [Color] = [.orange, .gray, .brown, .black, .white]
    let colorNames = ["주황이", "회색이", "갈색이", "검은이", "흰둥이"]

    var body: some View {
        ZStack {
            // 배경 그라데이션
            LinearGradient(
                colors: isAnimating
                    ? [.purple.opacity(0.3), .pink.opacity(0.3), .blue.opacity(0.3)]
                    : [.blue.opacity(0.2), .cyan.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.5), value: isAnimating)

            VStack(spacing: 40) {
                // 타이틀
                Text("Dancing Cat")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.purple, .pink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)

                Spacer()

                // 춤추는 고양이
                DancingCatView(isAnimating: $isAnimating, catColor: selectedColor)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

                // 상태 텍스트
                Text(isAnimating ? "신나게 춤추는 중!" : "터치해서 춤추게 하기")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .animation(.easeInOut, value: isAnimating)

                Spacer()

                // 컨트롤 버튼들
                VStack(spacing: 20) {
                    // 시작/정지 버튼
                    Button {
                        withAnimation {
                            isAnimating.toggle()
                        }
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: isAnimating ? "pause.fill" : "play.fill")
                                .font(.title2)
                            Text(isAnimating ? "춤 멈추기" : "춤추기 시작!")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(width: 200, height: 56)
                        .background(
                            LinearGradient(
                                colors: isAnimating
                                    ? [.red, .orange]
                                    : [.green, .mint],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(Capsule())
                        .shadow(color: isAnimating ? .red.opacity(0.4) : .green.opacity(0.4),
                               radius: 8, x: 0, y: 4)
                    }

                    // 색상 선택 버튼
                    Button {
                        showColorPicker.toggle()
                    } label: {
                        HStack(spacing: 8) {
                            Circle()
                                .fill(selectedColor)
                                .frame(width: 24, height: 24)
                                .overlay(Circle().stroke(.white, lineWidth: 2))
                            Text("고양이 색상 변경")
                                .font(.subheadline)
                        }
                        .foregroundColor(.primary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                    }
                }
                .padding(.bottom, 40)
            }
            .padding()
        }
        .sheet(isPresented: $showColorPicker) {
            ColorPickerSheet(
                selectedColor: $selectedColor,
                colors: catColors,
                colorNames: colorNames
            )
            .presentationDetents([.height(300)])
        }
    }
}

struct ColorPickerSheet: View {
    @Binding var selectedColor: Color
    @Environment(\.dismiss) var dismiss
    let colors: [Color]
    let colorNames: [String]

    var body: some View {
        VStack(spacing: 24) {
            Text("고양이 색상 선택")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 24)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 16) {
                ForEach(Array(zip(colors.indices, colors)), id: \.0) { index, color in
                    VStack(spacing: 8) {
                        Circle()
                            .fill(color)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Circle()
                                    .stroke(selectedColor == color ? .blue : .gray.opacity(0.3), lineWidth: 3)
                            )
                            .shadow(color: color.opacity(0.4), radius: 4, x: 0, y: 2)
                            .onTapGesture {
                                selectedColor = color
                                dismiss()
                            }

                        Text(colorNames[index])
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
    }
}

#Preview {
    ContentView()
}

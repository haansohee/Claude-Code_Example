# Dancing Cat iOS App

SwiftUI로 만든 춤추는 고양이 애니메이션 앱입니다.

## Screenshots

<p align="center">
  <img src="https://via.placeholder.com/300x600?text=Dancing+Cat+App" alt="App Screenshot" width="300">
</p>

## Features

- 귀여운 고양이 캐릭터 (SwiftUI Shape로 구현)
- 다양한 춤 애니메이션 (점프, 회전, 흔들기, 크기 변화)
- 애니메이션 시작/정지 제어
- 5가지 고양이 색상 선택 가능 (주황이, 회색이, 갈색이, 검은이, 흰둥이)
- 그라데이션 배경 효과

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. 이 저장소를 클론합니다:
```bash
git clone https://github.com/YOUR_USERNAME/DancingCat.git
```

2. Xcode에서 `DancingCat.xcodeproj`를 엽니다.

3. 시뮬레이터 또는 실제 기기를 선택하고 실행합니다 (Cmd + R).

## Project Structure

```
DancingCat/
├── DancingCatApp.swift    # App entry point
├── ContentView.swift      # Main screen with controls
├── DancingCatView.swift   # Cat character & animations
└── Assets.xcassets/       # App assets
```

## How It Works

### Cat Character
고양이 캐릭터는 SwiftUI `Shape` 프로토콜을 사용하여 벡터 그래픽으로 구현되었습니다:
- `CatShape`: 몸통, 머리, 귀, 꼬리
- `CatFace`: 눈, 코, 입, 수염

### Animations
SwiftUI의 `withAnimation`과 다양한 애니메이션 타입을 조합:
- `.easeInOut` - 점프, 크기 변화
- `.linear` - 3D 회전
- `.repeatForever` - 무한 반복

## License

MIT License

## Author

Created with SwiftUI

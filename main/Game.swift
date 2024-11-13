#if os(iOS)
import Foundation
#endif

final class Game {
    init(levels: [Level]) {
        self.levels = levels
    }
    var levels: [Level]
    var currentLevel = 0
    var confirm = 0
    var level: Level {
        levels[currentLevel]
    }
    var localTime: Double = 0
    var selectTappedTime: Double = 0
    func render(screen: inout Screen, time: Double) {
        level.render(&screen, time)
        localTime = time
        if confirm > 0 {
            if time - selectTappedTime > 1 {
                confirm = confirm - 1
                selectTappedTime = time
            }
                
            let c1: Color
            let c2: Color
            let c3: Color
            switch confirm {
            case 1:
                c1 = .init(r: 16, g: 0, b: 0)
                c2 = .init(r: 0, g: 16, b: 0)
                c3 = .init(r: 0, g: 16, b: 0)
            case 2:
                c1 = .init(r: 16, g: 0, b: 0)
                c2 = .init(r: 16, g: 0, b: 0)
                c3 = .init(r: 0, g: 16, b: 0)
            case 3:
                c1 = .init(r: 16, g: 0, b: 0)
                c2 = .init(r: 16, g: 0, b: 0)
                c3 = .init(r: 16, g: 0, b: 0)
            default:
                c1 = .init(r: 16, g: 0, b: 0)
                c2 = .init(r: 0, g: 16, b: 0)
                c3 = .init(r: 0, g: 16, b: 0)
            }
            let center1: PointD = .init(x: 1.5, y: 2.5)
            let center2: PointD = .init(x: 4.5, y: 2.5)
            let center3: PointD = .init(x: 7.5, y: 2.5)
            for x in 0 ..< screen.width {
                for y in 0 ..< screen.height {
                    let p = PointD(x: Double(x), y: Double(y))
                    if p.distance(to: center1) < 1.1 {
                        screen.setPixel(x: x, y: y, color: c1)
                    } else if p.distance(to: center2) < 1.1 {
                        screen.setPixel(x: x, y: y, color: c2)
                    } else if p.distance(to: center3) < 1.1 {
                        screen.setPixel(x: x, y: y, color: c3)
                    } else {
                        screen.addPixel(x: x, y: y, color: .off)
                    }
                }
            }
            
        }
    }
    
    func buttonTapped(button: Button.Value) {
        if case .select = button {
            confirm += 1
            selectTappedTime = localTime
            if confirm == 4 {
                let nextLevel = (currentLevel + 1) % levels.count
                currentLevel = nextLevel
                confirm = 0   
            }
            return
        }
        // Mens man skifter bane må man ikke bevæge sig
        guard confirm == 0 else { return }
        level.buttonTapped(button)
    }
}

struct Level {
    var render: (inout Screen, Double) -> Void
    var buttonTapped: RunLoop.Callback
}

#if os(iOS)
    import Foundation
#endif

private let labyrinth: [UInt8] = [
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 3, 1,
    1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1,
    1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1,
    1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1,
    1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1,
    1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1,
    1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1,
    1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1,
    1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1,
    1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1,
    1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1,
    1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1,
    1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1,
    1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1,
    1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1,
    1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1,
    1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
]

enum Tile: UInt8 {
    case start = 2
    case end = 3
    case wall = 1
    case space = 0
}

extension Tile {
    #if os(iOS)

        var color: Color {
            switch self {
            case .start:
                .init(r: 0, g: 16, b: 0)
            case .end:
                .init(r: 16, g: 0, b: 0)
            case .wall:
                .init(r: 8, g: 0, b: 8)
            case .space:
                .init(r: 2, g: 2, b: 2)
            }
        }
    #else
        var color: Color {
            switch self {
            case .start:
                .init(r: 0, g: 16, b: 0)
            case .end:
                .init(r: 16, g: 0, b: 0)
            case .wall:
                .init(r: 2, g: 0, b: 2)
            case .space:
                .off
            }
        }

    #endif

}

//   .init(r: 0, g: 16, b: 0)
// case .end:
//   .init(r: 16, g: 0, b: 0)
// case .wall:
//   .init(r: 2, g: 0, b: 2)

struct Labyrinth {
    let width = 20
    let height = 20
    func getTile(_ point: Point) -> Tile {
        guard point.x >= 0 && point.x < width else { return .space }
        guard point.y >= 0 && point.y < height else { return .space }

        let tileInt = labyrinth[point.x + ((height - 1) - point.y) * width]
        return Tile(rawValue: tileInt) ?? .space
    }
}

func createLabyrinthLevel() -> Level {
    let labyrinth = Labyrinth()
    var player = Point(x: 1, y: 1)
    var toggleLed: Bool = false

    let labyrinthLevel: Level = .init { screen, time in
        // Time is in seconds
        var t = fmodf(Float(time), 1)
        if t > 0.50 {
            t = 1 - t
        }
        let center = Point(x: 5, y: 3)

        var t2 = fmodf(Float(time / 5), 1)
        if t2 > 0.5 {
            t2 = 1 - t2
        }

        screen.red = Double(t2)
        screen.blue = Double(0.5 - t2)
        // if toggleLed {
        //     screen.blue = true
        //     screen.red = false
        // } else {
        //     screen.blue = false
        //     screen.red = true
        // }

        for x in 0..<screen.width {
            for y in 0..<screen.height {
                let p = Point(x: x, y: y)
                let transformed = (p + player) - center
                let tile = labyrinth.getTile(transformed)

                if p == center {
                    let color = Color(
                        r: tile.color.r, g: tile.color.g, b: max(UInt8(8 + t * 8), tile.color.b))
                    screen.setPixel(x: x, y: y, color: color)
                } else {
                    screen.setPixel(x: x, y: y, color: tile.color)
                }
            }
        }
    } buttonTapped: { button in
        var next = player
        switch button {
        case .left:
            next.x -= 1
        case .right:
            next.x += 1
        case .up:
            next.y += 1
        case .down:
            next.y -= 1
        case .fire:
            toggleLed = !toggleLed
        case .select:
            ()
        }
        let tile = labyrinth.getTile(next)
        if tile != .wall {
            player = next
        }
    }

    return labyrinthLevel
}

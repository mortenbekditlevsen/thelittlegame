#if os(iOS)
import Foundation
#endif
let up: [Int] = [
    0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 1, 1, 1, 0, 0, 0, 0,
    0, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
]

let down: [Int] = [
    0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
    0, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    0, 0, 0, 1, 1, 1, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
]

let left: [Int] = [
    0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
    0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
    1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
    0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
]

let right: [Int] = [
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 1, 1, 0,
    0, 0, 0, 0, 1, 1, 1, 1, 1, 1,
    0, 0, 0, 0, 0, 0, 0, 1, 1, 0,
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
]

let upImage = Image(buffer: up, palette: .init(colors: [.blue]))
let downImage = Image(buffer: down, palette: .init(colors: [.yellow]))
let rightImage = Image(buffer: right, palette: .init(colors: [.red]))
let leftImage = Image(buffer: left, palette: .init(colors: [.green]))

struct Event {
    let duration: Double
    var startTime: Double = 0
    var started = false
    let action: (inout Screen, Double, Double) -> Void
}

func drawElement(direction: Direction, asUser: Bool = false) -> Event {
    Event(duration: 0.5) { screen, _, _ in
        let image = direction.image
        for x in 0 ..< screen.width {
            for y in 0 ..< screen.height {
                let c = image.getColor(x: x, y: y)
                screen.setPixel(x: x, y: 5 - y, color: c)
            }
        }
        if asUser {
            screen.blue = 1
        }
    }
}
func drawEmpty() -> Event {
    Event(duration: 0.5) { screen, _, _ in
        screen.blue = 0
        screen.red = 0
        for x in 0 ..< screen.width {
            for y in 0 ..< screen.height {
                screen.setPixel(x: x, y: 5 - y, color: .off)
            }
        }
    }
}

let win = Event(duration: 8) { screen, time, startTime in
    
    let delta = time - startTime
    let size = delta * 10
    let center = Point(x: 4, y: 3)
    for x in 0 ..< screen.width {
        for y in 0 ..< screen.height {
            let p = Point(x: x, y: y)
            
            let distance = center.distance(to: p)
            let colors: [Color] = [.red, .yellow, .green, .blue, .cyan, .pink]
            if  distance < size {
                let thingie = (20 - distance) / 3  + (delta * 2)
                let index = Int(thingie) % colors.count
                let next = (index == colors.count - 1) ? 0 : index + 1
                let c1 = colors[index]
                let c2 = colors[next]
                let remainder = thingie - floor(thingie)
                
                let color = Color(r: UInt8(Double(c2.r) * remainder + Double(c1.r) * (1 - remainder)), 
                                  g: UInt8(Double(c2.g) * remainder + Double(c1.g) * (1 - remainder)),
                                  b: UInt8(Double(c2.b) * remainder + Double(c1.b) * (1 - remainder)))
                screen.setPixel(x: x, y: y, color: color)
            }
        }
    }
}

let lose = Event(duration: 1, action: { screen, _, _ in
    screen.red = 1
    for x in 0 ..< screen.width {
        for y in 0 ..< screen.height {
            screen.setPixel(x: x, y: 5 - y, color: .red)
        }
    }
})

let levelLength = 10

func createMemoryLevel() -> Level {
    var events: [Event] = []
    var sequence: [Direction] = generateSequence(size: levelLength)
    var match: [Direction] = []
    var startNextStep = true
    var step = 0
    var showingStep = false
    
    let restart = Event(duration: 0, startTime: 0, started: false, action: { _, _, _ in
        step = 0
        sequence = generateSequence(size: levelLength)
        match = []
        startNextStep = true
    })
    
    let advanceToNextStep = Event(duration: 0, startTime: 0, started: false, action: { _, _, _ in
        startNextStep = true
        match = []
    })
    
    return Level { screen, time in
        if startNextStep {
            step += 1
            startNextStep = false
            showingStep = true
            
            for i in 0 ..< step {
                let element = sequence[i]
                if i == step - 1 {
                    // Immediately on showing last step, we start accepting input
                    events.append(Event(duration: 0, startTime: 0, started: false, action: { _, _, _ in
                        showingStep = false
                    }))
                    
                }
                events.append(drawElement(direction: element))
                events.append(drawEmpty())
            }            
        }

        if !events.isEmpty {
            if events[0].started, (events[0].startTime + events[0].duration) <= time {
                events.remove(at: 0)
            }
        }

        if !events.isEmpty {
            if events[0].startTime == 0 {
                events[0].startTime = time
                events[0].started = true
            }  
        }

        if !events.isEmpty, events[0].started {
            events[0].action(&screen, time, events[0].startTime)
        }
          
    } buttonTapped: { button in
        guard !showingStep else {
            return
        }
        if let direction = button.direction {
            match.append(direction)
            if match == Array(sequence.prefix(match.count)) {
                // Success, show input
                events.removeAll()
                events.append(drawElement(direction: direction, asUser: true))
                events.append(drawEmpty())
                if match.count == step {
                    if step == levelLength {
                        // WIN!
                        showingStep = true
                        events.append(win)
                        events.append(drawEmpty())
                        events.append(restart)
                        
                    } else {
                        events.append(advanceToNextStep)    
                    }
                        
                }
                
            } else {
                // Fail
                showingStep = true
                events.append(lose)
                events.append(drawEmpty())
                events.append(restart)    
            }
        }
        
    }

}

extension Button.Value {
    var direction: Direction? {
        switch self {
        case .down: .down
        case .up: .up
        case .left: .left
        case .right: .right
        case .fire: nil
        case .select: nil
        }
    }
}

enum Direction: Int {
    case up, right, down, left
    var image: Image {
        switch self {
        case .up: upImage
        case .down: downImage
        case .left: leftImage
        case .right: rightImage
        }
    }
}

func generateSequence(size: Int) -> [Direction] {
    var s: [Direction] = []
    for _ in 0 ..< size {
        let r = Int.random(in: 0 ..< 4)
        s.append(Direction(rawValue: r) ?? .up)
    }
    return s
}

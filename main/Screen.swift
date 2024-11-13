// final class Screen {
//   let ledStrip: LedStrip
//   var current: [Color]
//   var previous: [Color]
//   let width: Int
//   let height: Int
//   init(width: Int, height: Int) {
//     self.width = width
//     self.height = height
//     let n = width * height

//     self.ledStrip = LedStrip(gpioPin: 0, maxLeds: n)
//     self.current = .init(repeating: .off, count: n)
//     self.previous = .init(repeating: .off, count: n)

//     self.ledStrip.clear()
//   }

//   func update() {
//     var changes = false
//     for i in 0 ..< width * height {
//       if current[i] != previous[i] {
//         ledStrip.setPixel(index: i, color: current[i])
//         changes = true
//       }
//     }
//     if changes {
//       ledStrip.refresh()
//     }
//     previous = current
//   }

//   func setPixel(x: Int, y: Int, color: Color) {
//     current[y + x * height] = color
//   }
// }

struct Screen {
     let ledStrip: LedStrip
     let ledBlue: Led
     let ledRed: Led

    var current: [Color]
    var previous: [Color]
    var blue: Double = 0
    var red: Double = 0
    var bluePrev: Double = 0
    var redPrev: Double = 0
    let width: Int
    let height: Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        let n = width * height
        self.ledStrip = LedStrip(gpioPin: 0, maxLeds: n)
        self.ledBlue = Led(gpioPin: 18, timerNumber: LEDC_TIMER_0, channelNumber: LEDC_CHANNEL_0)
        self.ledRed = Led(gpioPin: 20, timerNumber: LEDC_TIMER_1, channelNumber: LEDC_CHANNEL_1)
        
        self.current = .init(repeating: .off, count: n)
        // Initialize previous with a different value from current
        // in order to perform an initial update that will set each
        // pixel to a valid value and perform a refresh.
        self.previous = .init(repeating: .lightWhite, count: n)
        self.update()
    }
    
    mutating func update() {
        var changes = false
        for i in 0 ..< width * height {
            if current[i] != previous[i] {
                ledStrip.setPixel(index: i, color: current[i])
                changes = true
            }
        }
        if changes {
            ledStrip.refresh()
        }
        previous = current
        if blue != bluePrev {
            ledBlue.setLed(value: blue)
            bluePrev = blue
        }
        if red != redPrev {
            ledRed.setLed(value: red)
            redPrev = red
        }
    }
    
    func get(x: Int, y: Int) -> Color {
        current[y + x * height]
    }
    
    mutating func setPixel(x: Int, y: Int, color: Color) {
        current[y + x * height] = color
    }
    mutating func addPixel(x: Int, y: Int, color: Color) {
        let c = current[y + x * height]  
        current[y + x * height] = Color(r: (c.r + color.r) / 2, 
                                        g: (c.g + color.g) / 2,
                                        b: (c.b + color.b) / 2)
    }
    
}

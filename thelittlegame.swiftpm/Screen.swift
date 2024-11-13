struct Screen {
    var current: [Color]
    var previous: [Color]
    var red: Double = 0
    var blue: Double = 0

    var bluePrev: Double = 0
    var redPrev: Double = 0

    let width: Int
    let height: Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        let n = width * height
        
        self.current = .init(repeating: .off, count: n)
        self.previous = .init(repeating: .off, count: n)
    }
    
    mutating func update() {
        var changes = false
        for i in 0 ..< width * height {
            if current[i] != previous[i] {
                //        ledStrip.setPixel(index: i, color: current[i])
                changes = true
            }
        }
        if changes {
            //      ledStrip.refresh()
        }
        previous = current
        
        if blue != bluePrev {
            bluePrev = blue
        }
        if red != redPrev {
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

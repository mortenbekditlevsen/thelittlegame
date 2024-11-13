

struct Color: Equatable {
    var r, g, b: UInt8
    static var white = Color(r: 255, g: 255, b: 255)
    static var lightWhite = Color(r: 16, g: 16, b: 16)
    static var lightRandom: Color {
        Color(r: .random(in: 0...8), g: .random(in: 0...8), b: .random(in: 0...8))
    }
    static var off = Color(r: 0, g: 0, b: 0)
}



struct Color: Equatable {
    var r, g, b: UInt8
    static var white = Color(r: 255, g: 255, b: 255)
    static var lightWhite = Color(r: 16, g: 16, b: 16)
    static var lightRandom: Color {
        Color(r: .random(in: 0...8), g: .random(in: 0...8), b: .random(in: 0...8))
    }
    static var off = Color(r: 0, g: 0, b: 0)
    
#if os(iOS)
    static var red: Color = .init(r: 16, g: 0, b: 0)
    static var orange: Color = .init(r: 16, g: 8, b: 0)
    static var pink: Color = .init(r: 16, g: 8, b: 12)
    static var green: Color = .init(r: 0, g: 16, b: 0)
    static var lightGreen: Color = .init(r: 5, g: 16, b: 5)
    static var blue: Color = .init(r: 5, g: 5, b: 16)
    static var lightBlue: Color = .init(r: 10, g: 10, b: 16)

#else
    static var red: Color = .init(r: 16, g: 0, b: 0)    
    static var orange: Color = .init(r: 12, g: 6, b: 0)
    static var pink: Color = .init(r: 16, g: 0, b: 8)
    static var green: Color = .init(r: 0, g: 16, b: 0)
    static var lightGreen: Color = .init(r: 5, g: 16, b: 5)
    static var blue: Color = .init(r: 0, g: 0, b: 16)
    static var lightBlue: Color = .init(r: 2, g: 2, b: 16)
    
#endif

}

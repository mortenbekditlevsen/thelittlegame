let catImage: [Int] = [
    0, 1, 3, 0, 0, 0, 0, 3, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    0, 1, 1, 2, 1, 1, 2, 1, 1, 0,
    0, 1, 1, 1, 3, 3, 1, 1, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
]

let unicornImage: [Int] = [
    0, 0, 0, 0, 3, 3, 0, 0, 0, 0,
    0, 1, 1, 0, 3, 3, 0, 1, 1, 3,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 3,                          
    0, 1, 1, 2, 1, 1, 2, 1, 1, 3,
    0, 1, 1, 1, 3, 3, 1, 1, 1, 3,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 3,
]

let rabbitImage: [Int] = [
    0, 1, 3, 0, 0, 0, 0, 3, 1, 0,
    0, 1, 3, 0, 0, 0, 0, 3, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,                          
    0, 1, 1, 2, 1, 1, 2, 1, 1, 0,
    0, 1, 1, 1, 3, 3, 1, 1, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
]
let pandaImage: [Int] = [
    0, 1, 3, 0, 0, 0, 0, 3, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    0, 1, 0, 0, 0, 1, 0, 0, 1, 0,
    0, 1, 0, 2, 0, 1, 2, 0, 1, 0,
    0, 1, 0, 0, 3, 3, 0, 0, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
]
let heartImage: [Int] = [
    0, 0, 1, 1, 0, 0, 1, 1, 0, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    0, 0, 1, 1, 1, 1, 1, 1, 0, 0,
    0, 0, 0, 1, 1, 1, 1, 0, 0, 0,
    0, 0, 0, 0, 1, 1, 0, 0, 0, 0,
]

let carrotImage: [Int] = [
    0, 0, 0, 0, 0, 0, 0, 2, 0, 2,
    0, 0, 0, 0, 0, 0, 2, 2, 2, 0,
    0, 0, 0, 0, 1, 1, 0, 0, 0, 2,
    0, 0, 0, 1, 1, 0, 0, 0, 0, 0,
    0, 0, 1, 1, 0, 0, 0, 0, 0, 0,
    0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
]

enum Pet: Int {
    static let imageWidth = 10
    case rabbit = 0
    case cat = 1
    case panda = 2
    case unicorn = 3
    case heart = 4
    case carrot = 5
    
    var image: [Int] {
        switch self {
        case .cat: catImage
        case .rabbit: rabbitImage
        case .panda: pandaImage
        case .heart: heartImage
        case .carrot: carrotImage
        case .unicorn: unicornImage
        }
    }
    var colors: [Color] {
        switch self {
        case .cat: [
            .init(r: 16, g: 8, b: 0),
            .init(r: 5, g: 16, b: 5),
            .init(r: 16, g: 8, b: 12),
            .init(r: 16, g: 0, b: 0),
        ]
        case .rabbit, .unicorn: [
            .init(r: 16, g: 16, b: 16),
            .init(r: 5, g: 5, b: 16),
            .init(r: 16, g: 8, b: 12),
            .init(r: 16, g: 0, b: 0)
        ]
            
        case .panda: [
            .init(r: 16, g: 16, b: 16),
            .init(r: 10, g: 10, b: 16),
            .init(r: 16, g: 8, b: 12),
            .init(r: 16, g: 0, b: 0)
        ]
        case .heart: [
            .init(r: 16, g: 0, b: 0),
        ]
        case .carrot: [
            .init(r: 16, g: 8, b: 0),
            .init(r: 0, g: 16, b: 0),
            
        ]
            
        }
    }
    func getColor(x: Int, y: Int) -> Color {
        let val = image[x + y * Pet.imageWidth]
        if val == 0 {
            return .off
        } else {
            let v = val - 1
            if v < colors.count {
                return colors[v]
            } else {
                return .off
            }
        }
    }
}

func createDigitalPetLevel() -> Level {
    var pet: Pet = .unicorn
    return Level { screen, t in
        for x in 0 ..< screen.width {
            for y in 0 ..< screen.height {
                let c = pet.getColor(x: x, y: y)
                screen.setPixel(x: x, y: 5 - y, color: c)
                
            }
        }
    } buttonTapped: { button in
        switch button {  
        case .down, .up, .left, .right:
            ()
        case .fire:
            pet = Pet(rawValue: pet.rawValue + 1) ?? .rabbit
            //pet = (pet == .cat) ? .rabbit : .cat
        case .select:
            ()
        }
    }    
}

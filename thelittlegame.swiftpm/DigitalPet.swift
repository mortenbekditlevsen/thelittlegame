let cat: [Int] = [
    0, 1, 3, 0, 0, 0, 0, 3, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    0, 1, 1, 2, 1, 1, 2, 1, 1, 0,
    0, 1, 1, 1, 3, 3, 1, 1, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
]

let unicorn: [Int] = [
    0, 0, 0, 0, 3, 3, 0, 0, 0, 0,
    0, 1, 1, 0, 3, 3, 0, 1, 1, 3,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 3,                          
    0, 1, 1, 2, 1, 1, 2, 1, 1, 3,
    0, 1, 1, 1, 3, 3, 1, 1, 1, 3,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 3,
]

let rabbit: [Int] = [
    0, 1, 3, 0, 0, 0, 0, 3, 1, 0,
    0, 1, 3, 0, 0, 0, 0, 3, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,                          
    0, 1, 1, 2, 1, 1, 2, 1, 1, 0,
    0, 1, 1, 1, 3, 3, 1, 1, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
]
let panda: [Int] = [
    0, 1, 3, 0, 0, 0, 0, 3, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    0, 1, 0, 0, 0, 1, 0, 0, 1, 0,
    0, 1, 0, 2, 0, 1, 2, 0, 1, 0,
    0, 1, 0, 0, 3, 3, 0, 0, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
]
let heart: [Int] = [
    0, 0, 1, 1, 0, 0, 1, 1, 0, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 1, 0,
    0, 0, 1, 1, 1, 1, 1, 1, 0, 0,
    0, 0, 0, 1, 1, 1, 1, 0, 0, 0,
    0, 0, 0, 0, 1, 1, 0, 0, 0, 0,
]

let carrot: [Int] = [
    0, 0, 0, 0, 0, 0, 0, 2, 0, 2,
    0, 0, 0, 0, 0, 0, 2, 2, 2, 0,
    0, 0, 0, 0, 1, 1, 0, 0, 0, 2,
    0, 0, 0, 1, 1, 0, 0, 0, 0, 0,
    0, 0, 1, 1, 0, 0, 0, 0, 0, 0,
    0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
]

struct Size {
    let width: Int
    let height: Int
}

struct Palette {
    let colors: [Color]
}

struct Image {
    let buffer: [Int]
    let size: Size
    let palette: Palette
    
    init(buffer: [Int], size: Size = .init(width: 10, height: 6), palette: Palette) {
        self.buffer = buffer
        self.size = size
        self.palette = palette
    }
    
    func getColor(x: Int, y: Int) -> Color {
        let index = x + y * size.width
        guard index < buffer.count else {
            return .off
        }
        let val = buffer[index]
        if val == 0 {
            return .off
        } else {
            let v = val - 1
            if v < palette.colors.count {
                return palette.colors[v]
            } else {
                return .off
            }
        }
    }

}

let catImage = Image(buffer: cat, palette: Palette(colors: [
    .init(r: 16, g: 8, b: 0),
    .init(r: 5, g: 16, b: 5),
    .init(r: 16, g: 8, b: 12),
    .init(r: 16, g: 0, b: 0),
]))

let rabbitImage = Image(buffer: rabbit, palette: Palette(colors: [
    .init(r: 16, g: 16, b: 16),
    .init(r: 5, g: 5, b: 16),
    .init(r: 16, g: 8, b: 12),
    .init(r: 16, g: 0, b: 0)
]))

let unicornImage = Image(buffer: unicorn, palette: Palette(colors: [
    .init(r: 16, g: 16, b: 16),
    .init(r: 5, g: 5, b: 16),
    .init(r: 16, g: 8, b: 12),
    .init(r: 16, g: 0, b: 0)
]))

let pandaImage = Image(buffer: panda, palette: Palette(colors: [
    .init(r: 16, g: 16, b: 16),
    .init(r: 10, g: 10, b: 16),
    .init(r: 16, g: 8, b: 12),
    .init(r: 16, g: 0, b: 0)
]))

let heartImage = Image(buffer: heart, palette: Palette(colors: [
    .init(r: 16, g: 0, b: 0),
]))

let carrotImage = Image(buffer: carrot, palette: Palette(colors: [
    .init(r: 16, g: 8, b: 0),
    .init(r: 0, g: 16, b: 0),
]))

let cakeImage = Image(buffer: carrot, palette: Palette(colors: [
    .init(r: 0, g: 8, b: 0),
    .init(r: 0, g: 16, b: 0),
]))

let sushiImage = Image(buffer: carrot, palette: Palette(colors: [
    .init(r: 0, g: 8, b: 16),
    .init(r: 0, g: 16, b: 0),
]))

enum PetType: Int {
    case rabbit = 0
    case cat = 1
    case panda = 2
    case unicorn = 3
//case heart = 4
    
    var image: Image {
        switch self {
        case .cat: catImage
        case .rabbit: rabbitImage
        case .panda: pandaImage
     //   case .heart: heartImage
        case .unicorn: unicornImage
        }
    }
    
}

struct Pet {
    let petType: PetType
    mutating func eat(food: Food, at time: Double) {
        switch (petType, food) {
        case (.rabbit, .carrot),
             (.unicorn, .cake),
            (.panda, .sushi):
            self.happyness += 1
            self.time = time
        
        default:
            ()
        }
    }
    mutating func tick(_ now: Double) {
        if now - time > 2, happyness > 0 {
            happyness -= 1
            time = 0
        }
    }
    var happyness: Int = 0
    var time: Double = 0
}

enum Food: Int {
    case carrot = 0
    case cake = 1
    case sushi = 2
    
    var image: Image {
        switch self {
        case .carrot: carrotImage
        case .cake: cakeImage
        case .sushi: sushiImage
        }
    }
}

func createDigitalPetLevel() -> Level {
    var pet: Pet = Pet(petType: .unicorn)
    var food: Food?
    var time: Double = 0
    return Level { screen, t in
        time = t
        for x in 0 ..< screen.width {
            for y in 0 ..< screen.height {
                let image: Image
                if let food {
                    image = food.image
                } else if pet.happyness > 0 {
                    image = heartImage
                    pet.tick(t)
                } else {
                    image = pet.petType.image
                }
                let c = image.getColor(x: x, y: y)
                screen.setPixel(x: x, y: 5 - y, color: c)
            }
        }
    } buttonTapped: { button in
        switch button {  
        case .down, .up, .left:
            food = nil
        case .right:
            if let currentFood = food {
                food = Food(rawValue: currentFood.rawValue + 1) // passing over the end will select nil
            } else {
                food = .carrot
            }
        case .fire:
            if let currentFood = food {
                pet.eat(food: currentFood, at: time)
                food = nil
            } else {
                pet = Pet(petType: PetType(rawValue: pet.petType.rawValue + 1) ?? .rabbit)
            }
         case .select:
            ()
        }
    }    
}

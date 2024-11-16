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

let sushi: [Int] = [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 1, 1, 1, 1, 1, 1, 0, 0,
    0, 0, 1, 2, 2, 3, 3, 1, 0, 0,
    0, 0, 1, 2, 2, 3, 3, 1, 0, 0,
    0, 0, 1, 1, 1, 1, 1, 1, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
]

let icecream: [Int] = [
    0, 0, 0, 2, 2, 2, 0, 0, 0, 0,
    0, 0, 3, 3, 3, 3, 3, 0, 0, 0,
    0, 0, 2, 2, 2, 2, 2, 0, 0, 0,
    0, 0, 1, 1, 1, 1, 1, 0, 0, 0,
    0, 0, 0, 1, 1, 1, 0, 0, 0, 0,
    0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
]

let fish: [Int] = [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 1, 1, 1, 1, 0, 0, 1, 0,
    0, 1, 0, 1, 1, 1, 1, 1, 0, 0,
    0, 1, 1, 1, 1, 1, 1, 1, 0, 0,
    0, 0, 1, 1, 1, 1, 0, 0, 1, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
    .orange,
    .green,
    .pink,
]))

let rabbitImage = Image(buffer: rabbit, palette: Palette(colors: [
    .lightWhite,
    .blue,
    .pink,
]))

let unicornImage = Image(buffer: unicorn, palette: Palette(colors: [
    .lightWhite,
    .blue,
    .pink,
]))

let pandaImage = Image(buffer: panda, palette: Palette(colors: [
    .lightWhite,
    .lightBlue,
    .pink,
]))

let heartImage = Image(buffer: heart, palette: Palette(colors: [
    .red
]))

let carrotImage = Image(buffer: carrot, palette: Palette(colors: [
    .orange,
    .green,
]))

let icecreamImage = Image(buffer: icecream, palette: Palette(colors: [
    .orange,
    .pink,
    .init(r: 4, g: 0, b: 4),
]))

let fishImage = Image(buffer: fish, palette: Palette(colors: [
    .lightBlue,
]))


let sushiImage = Image(buffer: sushi, palette: Palette(colors: [
    .lightWhite,
    .pink,
    .green,
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
        case .unicorn: unicornImage
        }
    }
    
}

struct Pet {
    let petType: PetType
    mutating func eat(food: Food, at time: Double) {
        //switch (petType, food) {
        //case (.rabbit, .carrot),
        
        // (.unicorn, .icecream),
        // (.panda, .sushi):
        self.happyness += 1
        self.showHeart = true
        self.time = time
        
        //default:
        //  ()
        //}
    }
    mutating func tick(_ now: Double) {
        if now - time > 1.9, showHeart {
            showHeart = false
            // time = 0
        }
        if now - time > 2, happyness > 0 {
            time = now
            happyness -= 1
        }
    }
    var happyness: Int = 0
    var time: Double = 0
    var showHeart: Bool = false
}

enum Food: Int {
    case carrot = 0
    case icecream = 1
    case sushi = 2
    case fish = 3
    
    var image: Image {
        switch self {
        case .carrot: carrotImage
        case .icecream: icecreamImage
        case .sushi: sushiImage
        case .fish: fishImage
        }
    }
}

func createDigitalPetLevel() -> Level {
    var pet: Pet = Pet(petType: .unicorn)
    var food: Food?
    var time: Double = 0
    return Level { screen, t in
        time = t
        screen.red = Double(pet.happyness) / 5
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

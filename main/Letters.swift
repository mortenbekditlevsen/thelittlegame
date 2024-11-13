func bajm() {
  let b: [UInt8] = [
    1, 1, 1, 1, 0, 0,
    1, 0, 0, 0, 1, 0,
    1, 0, 0, 0, 1, 0,
    1, 0, 0, 0, 1, 0,
    1, 1, 1, 1, 0, 0,
    1, 0, 0, 0, 1, 0,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 1, 1, 1, 1, 0,
  ]

  let a: [UInt8] = [
    0, 0, 1, 1, 0, 0,
    0, 1, 0, 0, 1, 0,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 1, 1, 1, 1, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
  ]

  let m: [UInt8] = [
    1, 0, 0, 0, 0, 1,
    1, 1, 0, 0, 1, 1,
    1, 0, 1, 1, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
  ]

  let j: [UInt8] = [
    1, 1, 1, 1, 1, 1,
    0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    0, 1, 0, 0, 1, 0,
    0, 0, 1, 1, 0, 0,
  ]

  let hjerte: [UInt8] = [
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 1, 0, 1, 0,
    0, 1, 2, 1, 2, 1,
    0, 1, 2, 2, 2, 1,
    0, 0, 1, 2, 1, 0,
    0, 0, 0, 1, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
  ]

  let seven: [UInt8] = [
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1,
    0, 1, 0, 0, 1, 0,
    0, 0, 1, 1, 0, 0,
  ]

  let w = 6
  let h = 10
  let n = w * h
  let ledStrip = LedStrip(gpioPin: 0, maxLeds: n)
  ledStrip.clear()

  var colors: [Color] = .init(repeating: .off, count: n)
  var i = 0
  let button = Button(gpioPin: 9, value: .up)

  var pressed = true
  var primary: UInt8 = 1
  var secondary: UInt8 = 2
  while true {
    colors.removeLast()
    colors.insert(.lightRandom, at: 0)
    let buttonState = button.getValue()
    let newPressed = buttonState == 0
    let toggled: Bool
    let tapped: Bool
    if newPressed != pressed {
      pressed = newPressed
      toggled = true
    } else {
      toggled = false
    }
    if toggled && newPressed {
      tapped = true
    } else {
      tapped = false
    }

    if tapped {
      let x = primary
      primary = secondary
      secondary = x
    }

    for x in 0..<w {
      for y in 0..<h {
        let arr: [UInt8]
        let c: Color
        // switch i % 80 {
        //   case 0 ..< 20:
        //   arr = b
        //   c = .init(r: 50, g: 0, b: 0, w: 16)
        //   case 20 ..< 40:
        //   arr = a
        //   c = .init(r: 50, g: 0, b: 0, w: 16)
        //   case 40 ..< 60:
        //   arr = j
        //   c = .init(r: 50, g: 7, b: 7, w: 16)
        //   case 60 ..< 80:
        //   arr = m
        //   c = .init(r: 0, g: 30, b: 0, w: 16)
        //   default:
        //   arr = m
        //   c = .init(r: 0, g: 50, b: 0, w: 16)
        // }
        arr = hjerte

        switch arr[x + y * w] {
        case primary:
          ledStrip.setPixel(x: x, y: y, color: .init(r: 16, g: 0, b: 0))
        case secondary:
          ledStrip.setPixel(x: x, y: y, color: colors[x + y * w])
        case 0:
          ledStrip.setPixel(x: x, y: y, color: .off)
        default:
          ledStrip.setPixel(x: x, y: y, color: .off)
        }
      }
    }

    //         ledStrip.setPixel(x: 5, y: 9, color: .init(r: 255, g: 255, b: 0, w: 255))

    ledStrip.refresh()

    let blinkDelayMs: UInt32 = 100
    vTaskDelay(blinkDelayMs / (1000 / UInt32(configTICK_RATE_HZ)))
    i += 1
  }
}

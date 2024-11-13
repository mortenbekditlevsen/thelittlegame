//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

// let LEDC_TIMER =             LEDC_TIMER_0
// let LEDC_MODE =              LEDC_LOW_SPEED_MODE
// let LEDC_OUTPUT_IO: Int32 =         18 // Define the output GPIO
// let LEDC_CHANNEL   =         LEDC_CHANNEL_0
// let LEDC_DUTY_RES  =         LEDC_TIMER_13_BIT // Set duty resolution to 13 bits
// let LEDC_DUTY: UInt32      =  32 // 256 //  1024 //  2048 //  (4096) // Set duty to 50%. (2 ** 13) * 50% = 4096
// let LEDC_FREQUENCY: UInt32 =         (4000) // Frequency in Hertz. Set frequency at 4 kHz


// let LEDC_TIMER1 =             LEDC_TIMER_1
// let LEDC_OUTPUT_IO_2: Int32 =         20 // Define the output GPIO
// let LEDC_CHANNEL1   =         LEDC_CHANNEL_1


// func example_ledc_init() {
//     // Prepare and then apply the LEDC PWM timer configuration
//     var  ledc_timer = ledc_timer_config_t(
//         speed_mode: LEDC_MODE,
//         duty_resolution: LEDC_DUTY_RES,
//       timer_num: LEDC_TIMER,
//         freq_hz: LEDC_FREQUENCY,  // Set output frequency at 4 kHz
//         clk_cfg: LEDC_AUTO_CLK,
//         deconfigure: false
//     )
//     ledc_timer_config(&ledc_timer)

//         var  ledc_timer2 = ledc_timer_config_t(
//         speed_mode: LEDC_MODE,
//         duty_resolution: LEDC_DUTY_RES,
//       timer_num: LEDC_TIMER1,
//         freq_hz: LEDC_FREQUENCY,  // Set output frequency at 4 kHz
//         clk_cfg: LEDC_AUTO_CLK,
//         deconfigure: false
//     )
//     ledc_timer_config(&ledc_timer2)



//     // Prepare and then apply the LEDC PWM channel configuration
//     var ledc_channel = ledc_channel_config_t(
//               gpio_num: LEDC_OUTPUT_IO,
//         speed_mode: LEDC_MODE,
//         channel: LEDC_CHANNEL,
//         intr_type: LEDC_INTR_DISABLE,
//         timer_sel: LEDC_TIMER,
//         duty: 4096, // Set duty to 0%
//         hpoint: 0,
//         flags: .init()
//     )
//     ledc_channel_config(&ledc_channel)

//     var ledc_channel2 = ledc_channel_config_t(
//               gpio_num: LEDC_OUTPUT_IO_2,
//         speed_mode: LEDC_MODE,
//         channel: LEDC_CHANNEL1,
//         intr_type: LEDC_INTR_DISABLE,
//         timer_sel: LEDC_TIMER,
//         duty: 4096, // Set duty to 0%
//         hpoint: 0,
//         flags: .init()
//     )
//     ledc_channel_config(&ledc_channel2)


//     ledc_set_duty(LEDC_MODE, LEDC_CHANNEL, LEDC_DUTY)
//     ledc_update_duty(LEDC_MODE, LEDC_CHANNEL)

//     ledc_set_duty(LEDC_MODE, LEDC_CHANNEL1, LEDC_DUTY)
//     ledc_update_duty(LEDC_MODE, LEDC_CHANNEL1)

// }


@_cdecl("app_main")
func app_main() {
  print("Hello from Swift on ESP32-C6!")

  //  var a = ledc_timer_config_t()
  //  a.duty_resolution = LEDC_TIMER_13_BIT
  //  a.freq_hz = 4000                      // frequency of PWM signal
  //  a.speed_mode = LEDC_LS_MODE           // timer mode
  //  a.timer_num = LEDC_LS_TIMER            // timer index
  //  a.clk_cfg = LEDC_AUTO_CLK              // Auto select the source clock

  //  ledc_timer_config(&a);
  // example_ledc_init()


  let game = Game(
    levels: [
      createLabyrinthLevel(),
      createDigitalPetLevel(),
    ]
  )

  let runLoop = RunLoop()

  runLoop.callback = game.buttonTapped
  runLoop.render = game.render

runLoop.run()
//  plasma()
}
/*
func plasma() {
  let labyrinth = Labyrinth()
  let runLoop = RunLoop()

  var player = Point(x: 1, y: 1)

  let callback: RunLoop.Callback = { button in
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
      next.y += 2
    case .select:
      next.y -= 2
    }
    let tile = labyrinth.getTile(next)
    if tile != .wall {
      player = next
    }
  }

  runLoop.register(callback: callback)

  runLoop.render = { screen, time in
    // Time is currently in 1/100 of a second
    var t = time % 100
    if t > 50 {
      t = 100 - t
    }
    let center = Point(x: 5, y: 3)

    for x in 0..<screen.width {
      for y in 0..<screen.height {
        let p = Point(x: x, y: y)
        let transformed = (p + player) - center
        let tile = labyrinth.getTile(transformed)

        if p == center {
          let color = Color(
            r: tile.color.r, g: tile.color.g, b: max(UInt8(6 + t / 5), tile.color.b))
          screen.setPixel(x: x, y: y, color: color)
        } else {
          screen.setPixel(x: x, y: y, color: tile.color)
        }
      }
    }
  }

  runLoop.run()
}
*/
/*
extension Tile {
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
}
*/

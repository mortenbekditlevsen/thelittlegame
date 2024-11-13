final class RunLoop {
  typealias Callback = (Button.Value) -> Void
  var buttons: [Button] = []
  var callback: Callback = { _ in }
  var screen: Screen
  var render: (inout Screen, Double) -> Void = { _, _ in }

  init() {
    self.screen = Screen(width: 10, height: 6)
  }

  // func register(callback: @escaping Callback) {
  //   callbacks.append(callback)
  // }

  func setup() {
    buttons.append(Button(gpioPin: 2, value: .left))
    buttons.append(Button(gpioPin: 1, value: .up))
    buttons.append(Button(gpioPin: 21, value: .right))
    buttons.append(Button(gpioPin: 22, value: .down))
    buttons.append(Button(gpioPin: 16, value: .select))
    buttons.append(Button(gpioPin: 23, value: .fire))
  }

  func run() {
    setup()
    var t: Double = 0
    while true {
      for button in buttons {
        button.poll()
        if button.pressed {
            callback(button.value)
        }
      }
      render(&screen, t)
      screen.update()
      let delayMs: UInt32 = 30
      vTaskDelay(delayMs / (1000 / UInt32(configTICK_RATE_HZ)))
      t += 30 / 1000
    }
  }
}

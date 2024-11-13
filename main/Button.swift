class Button {
  enum Value {
    case up, down, left, right, select, fire
  }
  var button: gpio_num_t
  var state: Int32 = 1
  var toggled: Bool = false
  var toggledOn: Bool = false
  let value: Value
  init(gpioPin: Int, value: Value) {
    self.value = value
    button = gpio_num_t(Int32(gpioPin))

    guard gpio_reset_pin(button) == ESP_OK else {
      fatalError("cannot reset button")
    }

    guard gpio_set_direction(button, GPIO_MODE_INPUT) == ESP_OK else {
      fatalError("cannot reset button")
    }
  }

  func poll() {
    let newState = getValue()
    toggled = state != newState
    toggledOn = toggled && newState == 0
    state = newState
  }

  var pressed: Bool {
    toggledOn
  }

  func getValue() -> Int32 {
    gpio_get_level(button)
  }

}

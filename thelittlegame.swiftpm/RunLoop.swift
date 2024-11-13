class Button {
    enum Value {
        case up, down, left, right, fire, select
    }
}

final class RunLoop {
  typealias Callback = (Button.Value) -> Void
  var callback: Callback = { _ in }
  //var screen: Screen
  var render: (inout Screen, Double) -> Void = { _, _ in }
    var time: Double = 0

  init() {
    //self.screen = Screen(width: 10, height: 6)
  }

  func register(callback: @escaping Callback) {
      self.callback = callback
  }

  func setup() {
    }
    /*
    func timerTick(time: Double) {
        render(&screen, time)
        self.time = time
    }
    func invoke(button: Button.Value) {
        callback(button)
        render(&screen, time)
    }
     */
    
  func run() {
  }
}

@_cdecl("app_main")
func app_main() {
  print("Hello from Swift on ESP32-C6!")

  let game = Game(
    levels: [
      createLabyrinthLevel(),
      createDigitalPetLevel(),
      createMemoryLevel()
    ]
  )

  let runLoop = RunLoop()

  runLoop.callback = game.buttonTapped
  runLoop.render = game.render

  runLoop.run()
}

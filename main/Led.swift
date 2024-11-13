let LEDC_TIMER =             LEDC_TIMER_0
let LEDC_MODE =              LEDC_LOW_SPEED_MODE
let LEDC_OUTPUT_IO: Int32 =         18 // Define the output GPIO
let LEDC_CHANNEL   =         LEDC_CHANNEL_0
let LEDC_DUTY_RES  =         LEDC_TIMER_13_BIT // Set duty resolution to 13 bits
let LEDC_DUTY: UInt32      =  32 // 256 //  1024 //  2048 //  (4096) // Set duty to 50%. (2 ** 13) * 50% = 4096
let LEDC_FREQUENCY: UInt32 =         (4000) // Frequency in Hertz. Set frequency at 4 kHz


let LEDC_TIMER1 =             LEDC_TIMER_1
let LEDC_OUTPUT_IO_2: Int32 =         20 // Define the output GPIO
let LEDC_CHANNEL1   =         LEDC_CHANNEL_1




struct Led {
//   var ledPin: gpio_num_t
    var ledc_timer: ledc_timer_config_t
    var ledc_channel: ledc_channel_config_t

  init(gpioPin: Int, timerNumber: ledc_timer_t, channelNumber: ledc_channel_t) {
    ledc_timer = ledc_timer_config_t(
        speed_mode: LEDC_MODE,
        duty_resolution: LEDC_DUTY_RES,
        timer_num: timerNumber,
        freq_hz: LEDC_FREQUENCY,  // Set output frequency at 4 kHz
        clk_cfg: LEDC_AUTO_CLK,
        deconfigure: false
    )
    ledc_timer_config(&ledc_timer)

    ledc_channel = ledc_channel_config_t(
              gpio_num: Int32(gpioPin),
        speed_mode: LEDC_MODE,
        channel: channelNumber,
        intr_type: LEDC_INTR_DISABLE,
        timer_sel: timerNumber,
        duty: 0, // Set duty to 0%
        hpoint: 0,
        flags: .init()
    )
    ledc_channel_config(&ledc_channel)



    // ledPin = gpio_num_t(Int32(gpioPin))

    // guard gpio_reset_pin(ledPin) == ESP_OK else {
    //   fatalError("cannot reset led")
    // }

    // guard gpio_set_direction(ledPin, GPIO_MODE_OUTPUT) == ESP_OK else {
    //   fatalError("cannot reset led")
    // }
  }
  func setLed(value: Double) {
    let val = min(max(value, 0), 1)
    // let level: UInt32 = value ? 1 : 0
    // gpio_set_level(ledPin, level)

    let LEDC_DUTY: UInt32      =  UInt32(128 * val) // 256 //  1024 //  2048 //  (4096) // Set duty to 50%. (2 ** 13) * 50% = 4096

    ledc_set_duty(LEDC_MODE, ledc_channel.channel, LEDC_DUTY)
    ledc_update_duty(LEDC_MODE, ledc_channel.channel)

  }
}

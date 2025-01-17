# thelittlegame
Experiments with embedded Swift on an ESP32C6

![The little game](assets/thelittlegame.jpeg)

I started with the ESP32C6 from Seeedstudio + the 6x10 LED matrix

My daughter, Bertha, (aged 7 when we started) thought that it was fun to program the LEDs, so we decided to make a game - or a collection of small games.

I found some buttons I had lying around - 4 that we could use for directional buttons and two for selectors.

Then I found two other LEDs, a red and a blue one.

I soldered it all on to a bread board (I'm pretty bad at soldering) and 3d-printed a case for the game.

![The little game - inside](assets/thelittlegame_inside.jpeg)

Here is a list of games that we have so far:

1. Labyrinth (a 20x20 labyrinth first drawn on paper and then later entered into a Swift Playground by Bertha)
2. Digital pet (work in progress, Bertha drew a unicorn, rabbit, cat and panda - and food: carrot, ice cream, sushi and fish. So far you can select a pet and feed it food, and it will show a heart. More to come!)
3. Memory game

We still need to add batteries. The LED matrix requires 5V. I added a voltage regulator that can take 6V as input (two CR2032). The ESP32C6 doesn't have a 5V battery input - 5V usually only comes when you power it through USB. But it appears, that if you put 5V on the place where the ESP usually delivers 5V (when USB is connected), then it appears to work.

I still need to add wiring for the batteries and a button to turn the thing on and off.

Since the feedback loop of flashing the ESP32 is a bit slow, I made a really small version of the 'game' in a Swift Playground using SwiftUI.

I share code rather primitively through symlinks, but it works.

My daughter draws drawings for the digital pets, and the layout of the labyrinth - all on an iPad, and then I can flash the device when we want to try it out on the real hardware. :-)


To build:

```sh
. ../esp32/esp-idf/export.sh
export TOOLCHAINS=org.swift.600202408131a
idf.py build
```

Here's the game in action:

https://github.com/user-attachments/assets/9859cd54-89d6-4cd9-b803-3f3a03b4566d


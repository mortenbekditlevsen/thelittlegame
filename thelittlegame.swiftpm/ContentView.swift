import SwiftUI
import Combine

@Observable
final class ViewModel {
    var game: Game
    let runLoop = RunLoop()
    let start = Date()
    var screen: Screen 
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init() {
        self.game = Game(
            levels: [
                createLabyrinthLevel(),
                createDigitalPetLevel(),
            ],
            currentLevel: 1
    
        )
        self.timer = Timer.publish(every: 1/30, on: .main, in: .common).autoconnect()
        self.screen = Screen(width: 10, height: 6)
        
        runLoop.callback = game.buttonTapped
        runLoop.render = game.render
    }
}

extension Color {
    var swiftUI: SwiftUI.Color {
        SwiftUI.Color(red: Double(r) / 16, green: Double(g) / 16, blue: Double(b) / 16)
    }
}

struct ContentView: View {
    let viewModel: ViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 2) {
                ForEach(0 ..< 6, id: \.self) { y in
                    HStack(spacing: 2) {
                        ForEach(0 ..< 10, id: \.self) { x in 
                            Spacer(minLength: 0)
                                .frame(width: 38, height: 38)
                                .background(viewModel.screen.get(x: x, y: 5 - y).swiftUI)
                                .foregroundColor(.black)
                            
                                .clipShape(.buttonBorder)
                        }    
                    }    
                }
            }
            .padding(10)
            .background(.black)
            .clipShape(.rect(cornerRadii: .init(topLeading: 5, bottomLeading: 5, bottomTrailing: 5, topTrailing: 5)))
            
            HStack {
                VStack {
                    SwiftUI.Button(action: {
                        viewModel.runLoop.callback(.select)
                        
                    }, label: {
                        Text(" ")    
                            .contentShape(Rectangle())
                            .frame(width: 100, height: 50)
                            .background(.blue)
                        //                  
                    })
                    .foregroundColor(.black)
                    .clipShape(.buttonBorder)
                    
                    
                    SwiftUI.Button(action: {
                        viewModel.runLoop.callback(.left)
                        
                    }, label: {
                        Text("←")    
                            .contentShape(Rectangle())
                            .frame(width: 100, height: 100)
                            .background(.purple)
                        //                  
                    })
                    .foregroundColor(.black)
                    .clipShape(.buttonBorder)
                }
                VStack {
                    
                    SwiftUI.Button(action: {
                        viewModel.runLoop.callback(.up)
                        
                    }, label: {
                        Text("↑")    
                            .contentShape(Rectangle())
                            .frame(width: 100, height: 100)
                            .background(.purple)
                        //                  
                    })
                    .foregroundColor(.black)
                    .clipShape(.buttonBorder)
                    
                    
                    SwiftUI.Button(action: {
                        viewModel.runLoop.callback(.down)
                        
                    }, label: {
                        Text("↓")    
                            .contentShape(Rectangle())
                            .frame(width: 100, height: 100)
                            .background(.purple)
                        //                  
                    })
                    .foregroundColor(.black)
                    .clipShape(.buttonBorder)
                    
                }
                VStack {
                    SwiftUI.Button(action: {
                        viewModel.runLoop.callback(.fire)
                        
                    }, label: {
                        Text(" ")    
                            .contentShape(Rectangle())
                            .frame(width: 100, height: 50)
                            .background(.green)
                        //                  
                    })
                      .foregroundColor(.black)
                    .clipShape(.buttonBorder)
                    
                    SwiftUI.Button(action: {
                        viewModel.runLoop.callback(.right)

                    }, label: {
                        Text("→")    
                            .contentShape(Rectangle())
                            .frame(width: 100, height: 100)
                            .background(.purple)
                        //                  
                    })
                    .foregroundColor(.black)
                    .clipShape(.buttonBorder)
                    
                    
                }
                
                
            }
        }
        .onReceive(viewModel.timer, perform: { timer in
            let t: Double = timer.timeIntervalSince(viewModel.start) 
            viewModel.runLoop.render(&viewModel.screen, t)
            //viewModel.runLoop.render(&viewModel.screen, t)
            //viewModel.screen.setPixel(x: 1, y: 2, color: .lightRandom)
        })
    }
}

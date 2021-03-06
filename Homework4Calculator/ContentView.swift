//
//  ContentView.swift
//  Homework4Calculator
//
//  Created by Andrey Guevara on 28/2/21.
//

import SwiftUI

enum CalculatorButton: String{
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equal, plus, minus, multiply, divide
    case decimal
    case ac, plusMinus, percent
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "X"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .equal: return "="
        case .decimal: return "."
        case .divide: return "/"
        default:
            return "AC"
        }
    }
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
}

class GlobalEnviroment: ObservableObject {
    @Published var display = "0"
    func inputHandler(calculatorBtn: CalculatorButton){
        self.display = calculatorBtn.title
    }
}

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnviroment
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 12){
                HStack{
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                ForEach(buttons, id: \.self){row in
                    HStack(spacing : 12){
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.env.inputHandler(calculatorBtn: button)
                            }) {
                                
                                if(button.title == "AC" ||
                                    button.title == "+/-" ||
                                    button.title == "%"
                                ){
                                    Text(button.title)
                                    .font(.system(size: 32))
                                        .frame(width:self.getButtonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12 ) / 4)
                                        .foregroundColor(.black)
                                        .background(button.backgroundColor)
                                        .cornerRadius(self.getButtonWidth(button: button))
                                }else{
                                    Text(button.title)
                                    .font(.system(size: 32))
                                        .frame(width:self.getButtonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12 ) / 4)
                                        .foregroundColor(.white)
                                        .background(button.backgroundColor)
                                        .cornerRadius(self.getButtonWidth(button: button))
                                }
                                
                                
                            
                            }
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
    func getButtonWidth(button: CalculatorButton) -> CGFloat{
        if button == .zero{
            return (UIScreen.main.bounds.width - 4 * 12 ) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12 ) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnviroment())
    }
}

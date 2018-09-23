import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    let errorMessage = "Ошибка"
    
    var numberOnScreen: Double   = 0
    var previousNumber: Double   = 0
    var performMath:    Bool     = false
    var operation: MathOperation = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    ///В соответствии с "tag" id изменяем и отображаем число на UI
    @IBAction func insertNumbers(_ sender: UIButton) {
        if performMath {
            displayLabel.text = "0"
            numberOnScreen    = 0
            performMath       = false
        }
        
        guard let displayedNumberStringValue = displayLabel.text else {
            return
        }
        
        guard displayedNumberStringValue.count < 9 else {
            return
        }
        
        displayLabel.text = displayedNumberStringValue == "0" ? String(sender.tag) : displayedNumberStringValue + String(sender.tag)
        numberOnScreen = Double(displayLabel.text ?? "0") ?? 0
    }
    
    ///Выполнение действий в соответстии с "tag" id
    @IBAction func options(_ sender: UIButton) {
        
        switch sender.tag {
        case 10: // , (Comma) - оператор позволяющий получить число с плавающей запятой
            guard let displayedNumberStringValue = displayLabel.text else {
                return
            }
            displayLabel.text = displayedNumberStringValue + "."
            
        case 11: // AC (All Clear) - очистить отображаемое число
            displayLabel.text = "0"
            numberOnScreen    = 0
            previousNumber    = 0
            performMath       = false
            operation         = .none
            
        case 12: // +/- (Sign swap) - замена знака числа
            guard let displayedNumberStringValue = displayLabel.text else {
                return
            }
            guard displayedNumberStringValue != "0" else {
                return
            }
            
            displayLabel.text = displayedNumberStringValue.contains("-") ? displayedNumberStringValue.replacingOccurrences(of: "-", with: "") : "-" + displayedNumberStringValue
            numberOnScreen *= -1
            
        case 13: // % (percent) - оператор для вычисления процента из числа
            guard let displayedNumberStringValue = displayLabel.text else {
                return
            }
            let value = (Double(displayedNumberStringValue) ?? 0) * 0.01
            
            displayLabel.text = value.isInt ? String(Int(value)) : String(value)
            numberOnScreen    = value
            performMath       = true
            
        case 14: // ÷ (Devide) - оператор для деления числа на число
            guard let displayedNumberStringValue = displayLabel.text else {
                return
            }
            operation      = .devide
            previousNumber = Double(displayedNumberStringValue) ?? 0
            performMath    = true
            
        case 15: // x (Multiply) - оператор умножения числа на число
            guard let displayedNumberStringValue = displayLabel.text else {
                return
            }
            operation      = .multiply
            previousNumber = Double(displayedNumberStringValue) ?? 0
            performMath    = true
        
        case 16: // - (Subtract) - оператор вычитания числа из числа
            guard let displayedNumberStringValue = displayLabel.text else {
                return
            }
            operation = .subtract
            previousNumber = Double(displayedNumberStringValue) ?? 0
            performMath    = true
            
        case 17: // + (Add) - оператор сложения числа с числом
            guard let displayedNumberStringValue = displayLabel.text else {
                return
            }
            operation = .add
            previousNumber = Double(displayedNumberStringValue) ?? 0
            performMath    = true
            
        case 18: // = (Equals) - оператор вычисления операции равенства
            doMath(operation: operation)
            
        default:
            return
        }
        
    }
    
    ///Исполнение математической операции в зависимости от указанной операции
    private func doMath(operation: MathOperation) {
    
        let result: Double?
        
        switch operation {
        case .devide:
            guard numberOnScreen != 0 else {
                displayLabel.text = errorMessage
                return
            }
            result = previousNumber / numberOnScreen
            
        case .multiply:
            result = previousNumber * numberOnScreen
        
        case .subtract:
            result = previousNumber - numberOnScreen
            
        case .add:
            result = previousNumber + numberOnScreen
        
        default:
            return
        }
        guard let value = result else {
            return
        }
        displayLabel.text = value.isInt ? String(Int(value)) : String(value)
        previousNumber = result ?? 0
        performMath = true
    }
}

//MARK: - Различные изменения системных UI компонентов
extension ViewController {
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
   
}

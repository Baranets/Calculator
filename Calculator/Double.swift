import Foundation

extension Double {
    ///Проверяет Double значение на возможность быть целочисленным(Int). Возвращает true если число целое (Примеры: 1) 8.0 может быть целочисленным, возвращет TRUE; 2) 5.5 не целочисленное, возвращает FALSE )
    var isInt: Bool {
        guard self < Double(Int.max) else {
            return false
        }
        let intValueOfDouble = Int(self)
        return Double(intValueOfDouble) == self
    }
}

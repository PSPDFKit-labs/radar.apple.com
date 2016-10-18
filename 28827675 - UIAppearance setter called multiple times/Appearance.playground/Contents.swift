import UIKit
import PlaygroundSupport

class View: UIView {
    override dynamic var backgroundColor: UIColor? {
        didSet {
            print("backgroundColor \(backgroundColor)")
        }
    }
}

View.appearance().backgroundColor = #colorLiteral(red: 0.2202886641, green: 0.7022308707, blue: 0.9593387842, alpha: 1)
View.appearance().backgroundColor = #colorLiteral(red: 0.1956433058, green: 0.2113749981, blue: 0.2356699705, alpha: 1)
View.appearance().backgroundColor = #colorLiteral(red: 0.4931360483, green: 0, blue: 0.1765155345, alpha: 1)

let v = View(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))

print("appearance setter is called 3 times, but ideally it should be called just once with the last value:")

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView =  v

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet var riskInput: NSTextField!
    @IBOutlet var profitXInput: NSTextField!
    @IBOutlet var enterInput: NSTextField!
    @IBOutlet var stopLossInput: NSTextField!
    @IBOutlet var takeProfitInput: NSTextField!
    @IBOutlet var sharesToBuyInput: NSTextField!

    enum TradeType: Int {
        case short, long
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeChanged(self)
    }
    
    func controlTextDidChange(_ obj: Notification) {
        typeChanged(self)
    }
    
    @IBAction func quitWindowButtonTapped(button: NSButton) {
        exit(0)
    }

    func typeChanged(_ sender: Any) {
        if !riskInput.stringValue.isEmpty && !profitXInput.stringValue.isEmpty &&
            !enterInput.stringValue.isEmpty && !stopLossInput.stringValue.isEmpty {
            
            let takeProfit, sharesToBuy: Float
            let tradeType = getTradeType(enter: enterInput.floatValue, stopLoss: stopLossInput.floatValue)
            
            if tradeType == TradeType.short {
                sharesToBuy = riskInput.floatValue / (enterInput.floatValue - stopLossInput.floatValue)
                takeProfit = enterInput.floatValue + ((enterInput.floatValue - stopLossInput.floatValue) * profitXInput.floatValue)
            } else {
                sharesToBuy = riskInput.floatValue / (stopLossInput.floatValue - enterInput.floatValue)
                takeProfit = enterInput.floatValue - ((stopLossInput.floatValue - enterInput.floatValue) * profitXInput.floatValue)
            }
            if isNotInfiniteOrNan(a: sharesToBuy) && isNotInfiniteOrNan(a: takeProfit) {
                sharesToBuyInput.intValue = Int32(sharesToBuy)
                takeProfitInput.stringValue = String(format: "%.2f", takeProfit)
            }
        }
        
    }
    
    func getTradeType(enter: Float, stopLoss: Float) -> TradeType {
        if stopLoss < enter {
            return TradeType.short
        }
        return TradeType.long
    }
    
    func isNotInfiniteOrNan(a: Float) -> Bool {
        if a != Float.infinity && a != Float.nan {
            return true
        }
        return false
    }
        

}

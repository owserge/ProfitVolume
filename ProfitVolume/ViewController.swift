import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet var risk: NSTextField!
    @IBOutlet var profitX: NSTextField!
    @IBOutlet var enter: NSTextField!
    @IBOutlet var stopLoss: NSTextField!
    @IBOutlet var takeProfit: NSTextField!
    @IBOutlet var sharesToBuy: NSTextField!
 
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

    func typeChanged(_ sender: Any) {
        if !risk.stringValue.isEmpty && !profitX.stringValue.isEmpty && !enter.stringValue.isEmpty && !stopLoss.stringValue.isEmpty {
            
            let takeProfitValue, sharesToBuyValue: Float
            let tradeType = getTradeType(enter: enter.floatValue, stopLoss: stopLoss.floatValue)
            
            if tradeType == TradeType.short {
                sharesToBuyValue = risk.floatValue / (enter.floatValue - stopLoss.floatValue)
                takeProfitValue = enter.floatValue + ((enter.floatValue - stopLoss.floatValue) * profitX.floatValue)
            } else {
                sharesToBuyValue = risk.floatValue / (stopLoss.floatValue - enter.floatValue)
                takeProfitValue = enter.floatValue - ((stopLoss.floatValue - enter.floatValue) * profitX.floatValue)
            }
            if isNotInfiniteOrNan(a: sharesToBuyValue) && isNotInfiniteOrNan(a: takeProfitValue) {
                sharesToBuy.intValue = Int32(sharesToBuyValue)
                takeProfit.stringValue = String(format: "%.2f", takeProfitValue)
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

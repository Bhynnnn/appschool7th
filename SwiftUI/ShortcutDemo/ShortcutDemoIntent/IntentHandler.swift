import Intents
import SwiftUI

class IntentHandler: INExtension, BuyStockIntentHandling {
    
    @AppStorage("demostorage", store: UserDefaults(suiteName: "group.com.bhyn.appgroup"))
    var store: Data = Data()
    var purchaseData = PurchaseData()
    override func handler(for intent: INIntent) -> Any {
        guard intent is BuyStockIntent else {
            fatalError("Unknown intent type : \(intent)")
        }
        return self
    }
    
    func handle(intent: BuyStockIntent, completion: @escaping (BuyStockIntentResponse) -> Void) {
        guard let symbol = intent.symbol, let quantity = intent.quantity else {
            completion(BuyStockIntentResponse(code: .failure, userActivity: nil))
            return
        }
        
        let result = makePurchase(symbol: symbol, quantity: quantity)
        
        if result {
            completion(BuyStockIntentResponse.success(quantity: quantity, symbol: symbol))
        } else {
            completion(BuyStockIntentResponse.failure(quantity:quantity, symbol: symbol))
        }
    }
    
    func resolveSymbol(for intent: BuyStockIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let symbol = intent.symbol {
            completion(INStringResolutionResult.success(with: symbol))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func resolveQuantity(for intent: BuyStockIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let symbol = intent.quantity {
            completion(INStringResolutionResult.success(with: symbol))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func makePurchase(symbol: String, quantity: String) -> Bool {
        var result = false
        let decoder = JSONDecoder()
        
        if let history = try? decoder.decode(PurchaseData.self, from: store){
            purchaseData = history
            result = purchaseData.saveTransaction(symbol: symbol, quantity: quantity)
        }
        return result
    }
}

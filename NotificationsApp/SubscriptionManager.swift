//
//  SubscriptionManager.swift
//  NotificationsApp
//
//  Created by Angelo Milonas on 5/21/25.
//

import StoreKit
import Combine

@MainActor
class SubscriptionManager: ObservableObject {
  static let shared = SubscriptionManager()
  @Published private(set) var isSubscribed = false
  private var product: Product?

  private init() {
    Task { await loadSubscriptionState() }
  }

  /// 1) Load product & check existing entitlements
  func loadSubscriptionState() async {
    do {
      
      let products = try await Product.products(for: ["com.angelomilonas.notifai.unlimited"])
      product = products.first

      for await result in Transaction.currentEntitlements {
        if case .verified(let tx) = result,
           tx.productID == product?.id {
          isSubscribed = true
          return
        }
      }
      isSubscribed = false

    } catch {
      print("❌ Failed to load subscription state:", error)
    }
  }

  /// 2) Trigger a purchase and update local state
  func purchase() async throws {
    guard let product = product else { return }
    let result = try await product.purchase()
    switch result {
    case .success(let verification):
      let tx = try checkVerified(verification)
      await tx.finish()
      isSubscribed = true
    default:
      break  // handle cancellations or pending
    }
  }

  private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
    switch result {
    case .verified(let safe): return safe
    case .unverified: throw StoreError.failedVerification
    }
  }

  enum StoreError: Error {
    case failedVerification
  }
}

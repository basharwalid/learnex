class PaymentIntention {
  final String clientSecret;
  final String id;
  final String status;
  final int intentionOrderId;
  final List<PaymentKey> paymentKeys;

  PaymentIntention({
    required this.clientSecret,
    required this.id,
    required this.status,
    required this.intentionOrderId,
    required this.paymentKeys,
  });
}

class PaymentKey {
  final int integration;
  final String key;
  final String gatewayType;
  final int orderId;

  PaymentKey({
    required this.integration,
    required this.key,
    required this.gatewayType,
    required this.orderId,
  });
}
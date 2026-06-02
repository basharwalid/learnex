class PaymentItem {
  final String name;
  final int amount;
  final String description;
  final int quantity;

  PaymentItem({
    required this.name,
    required this.amount,
    required this.description,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'amount': amount,
    'description': description,
    'quantity': quantity,
  };
}
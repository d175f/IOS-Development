double processOrder({
  required String orderId,
  required double itemPrice,
  String? promoCode,
  double? deliveryFee,
}) {
  double price = itemPrice;

  if (promoCode == 'SAVE10') {
    price = price * 0.9;
  }

  double finalDeliveryFee = deliveryFee ?? 500.0;

  double total = price + finalDeliveryFee;

  print('Order: $orderId');
  print('Item price: $itemPrice ₸');
  print('Promo code: $promoCode');
  print('Delivery fee: $finalDeliveryFee ₸');
  print('Final total: $total ₸');

  return total;
}

void main() {
  processOrder(
    orderId: 'Order001',
    itemPrice: 10000.0,
    promoCode: 'SAVE10',
  );
}

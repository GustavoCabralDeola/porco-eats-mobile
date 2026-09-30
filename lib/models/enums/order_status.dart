enum OrderStatus { received, preparing, outForDelivery, delivered, cancelled }

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.received:
        return 'Recebido';

      case OrderStatus.preparing:
        return 'Em preparo';

      case OrderStatus.outForDelivery:
        return 'Saindo para entrega';

      case OrderStatus.delivered:
        return 'Entregue';

      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }
}

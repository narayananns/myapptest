import '../../models/orderdetails.dart';

/// Provider to manage order items
/// Currently returns a static list of items
/// backend developer integrate the actual data fetching logic here
class OrderProvider {
  List<OrderItemModel> getOrderItems() {
    return [
      OrderItemModel(
        name: 'Denim Jacket',
        size: 'L',
        qty: 2,
        color: 'Blue',
        image: "assets/images/zoro.jpg",
        orderId: '#Sp-2024-00123',
      ),
      OrderItemModel(
        name: 'Running Shoe',
        size: '10',
        qty: 1,
        color: 'Black',
        image: "assets/images/zoro.jpg",
        orderId: '#Sp-2024-00123',
      ),
      OrderItemModel(
        name: 'Blue Shirt',
        size: 'L',
        qty: 1,
        color: 'Blue',
        image: 'assets/images/zoro.jpg',
        orderId: '#Sp-2024-00123',
      ),
      OrderItemModel(
        name: 'Watch',
        size: 'Free',
        qty: 1,
        color: 'Brown',
        image: 'assets/images/zoro.jpg',
        orderId: '#Sp-2024-00123',
      ),
    ];
  }
}




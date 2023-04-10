class Order {
  final String title;
  final String startAddress;
  final String destinationAddress;
  final String status;
  final double price;

  Order({
    required this.title,
    required this.startAddress,
    required this.destinationAddress,
    required this.status,
    required this.price
  });
}
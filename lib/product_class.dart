class Product {
  final String title;
  final List<String> imageUrl;
  final String price;
  final String productId;

  Product(
      {required this.productId,
      required this.title,
      required this.imageUrl,
      required this.price});
}

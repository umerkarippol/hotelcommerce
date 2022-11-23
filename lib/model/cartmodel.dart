class CartMOdel {
  late String name, image;
  late int qty, product_id;
  double? total;
  double? price;

  CartMOdel(
      {required this.name,
      required this.image,
      required this.price,
      this.qty = 1,
      required this.product_id,
      required this.total});
}

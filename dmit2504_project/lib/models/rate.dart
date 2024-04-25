class Rate {
  String name = '';
  String price = '';

  Rate({required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}

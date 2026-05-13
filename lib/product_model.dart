// ===================== PRODUCT MODEL =====================
class Product {
  final int? id;
  final String name;
  final String price;
  final String image;
  final double rating;
  final int reviews;
  final String color; // field baru

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    this.rating = 4.5,
    this.reviews = 120,
    this.color = 'Hitam',
  });

  factory Product.fromMap(Map<String, dynamic> map, {String idKey = 'id'}) {
    return Product(
      id: map[idKey] as int?,
      name: map['name'] as String,
      price: map['price'] as String,
      image: map['image'] as String,
      rating: (map['rating'] as num?)?.toDouble() ?? 4.5,
      reviews: map['reviews'] as int? ?? 120,
      color: map['color'] as String? ?? 'Hitam',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'price': price,
      'image': image,
      'rating': rating,
      'reviews': reviews,
      'color': color,
    };
  }

  Product copyWith({
    int? id,
    String? name,
    String? price,
    String? image,
    double? rating,
    int? reviews,
    String? color,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      color: color ?? this.color,
    );
  }
}

// ===================== CART ITEM MODEL =====================
class CartItem {
  final int? id;
  final int productId;
  final String name;
  final String price;
  final String image;
  final double rating;
  final int reviews;
  final String color;
  int quantity;

  CartItem({
    this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    this.rating = 4.5,
    this.reviews = 120,
    this.color = 'Hitam',
    this.quantity = 1,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as int?,
      productId: map['product_id'] as int,
      name: map['name'] as String,
      price: map['price'] as String,
      image: map['image'] as String,
      rating: (map['rating'] as num?)?.toDouble() ?? 4.5,
      reviews: map['reviews'] as int? ?? 120,
      color: map['color'] as String? ?? 'Hitam',
      quantity: map['quantity'] as int? ?? 1,
    );
  }

  int get priceInt {
    final cleaned = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  int get subtotal => priceInt * quantity;

  Product toProduct() => Product(
        id: productId,
        name: name,
        price: price,
        image: image,
        rating: rating,
        reviews: reviews,
        color: color,
      );
}

// ===================== PROFILE MODEL =====================
class UserProfile {
  final int? id;
  final String name;
  final String email;
  final String address;
  final int vouchers;
  final int orders;
  final int reviews;

  UserProfile({
    this.id,
    required this.name,
    required this.email,
    this.address = '',
    this.vouchers = 0,
    this.orders = 0,
    this.reviews = 0,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      address: map['address'] as String? ?? '',
      vouchers: map['vouchers'] as int? ?? 0,
      orders: map['orders'] as int? ?? 0,
      reviews: map['reviews'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'address': address,
      'vouchers': vouchers,
      'orders': orders,
      'reviews': reviews,
    };
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'product_model.dart';
import 'manageproduct.dart';

// ================================================================
// HOME PAGE
// ================================================================
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Product> products = [];
  bool isLoading = true;

  final DatabaseHelper _db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final data = await _db.getAllProducts();
      setState(() {
        products = data;
        isLoading = false;
      });
    } catch (e) {
      print('DEBUG ERROR: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Rifky Surya Pratama',
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          // Tombol Kelola Produk
          IconButton(
            icon: Icon(Icons.inventory_2_outlined, color: Colors.orange),
            tooltip: 'Kelola Produk',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ManageProductPage()),
              );
              _loadProducts(); // refresh setelah kembali dari kelola produk
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.orange))
          : RefreshIndicator(
              color: Colors.orange,
              onRefresh: _loadProducts,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner Promo
                    Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.orangeAccent],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Promo Hari Ini',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Diskon hingga 50%',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.phone_android,
                            color: Colors.white,
                            size: 50,
                          ),
                        ],
                      ),
                    ),

                    // Header jumlah produk
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Semua Produk',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${products.length} produk',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),

                    // Grid Produk
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: products.isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.all(40),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.inventory_2_outlined,
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Belum ada produk',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ManageProductPage(),
                                          ),
                                        );
                                        _loadProducts();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                      ),
                                      child: Text('Tambah Produk'),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.68,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  product: products[index],
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DetailPage(
                                          product: products[index],
                                        ),
                                      ),
                                    );
                                    _loadProducts(); // Sync status jika ada perubahan dari detail
                                  },
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FavoritePage()),
            ).then((_) {
              setState(() => _currentIndex = 0);
              _loadProducts();
            });
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartPage()),
            ).then((_) {
              setState(() => _currentIndex = 0);
              _loadProducts();
            });
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfilePage()),
            ).then((_) {
              setState(() => _currentIndex = 0);
              _loadProducts();
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ================================================================
// PRODUCT CARD WIDGET
// ================================================================
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Penanganan adaptif gambar (Aset lokal vs File Upload HP)
    Widget productSelectionImage;
    if (product.image.startsWith('assets/')) {
      productSelectionImage = Image.asset(
        product.image,
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => Icon(Icons.phone_android, size: 70, color: Colors.grey),
      );
    } else {
      productSelectionImage = Image.file(
        File(product.image),
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => Icon(Icons.phone_android, size: 70, color: Colors.grey),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: productSelectionImage,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 2),
                      Text(
                        '${product.rating} (${product.reviews})',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Badge Warna
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product.color,
                      style: TextStyle(fontSize: 10, color: Colors.orange[700]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// DETAIL PAGE
// ================================================================
class DetailPage extends StatefulWidget {
  final Product product;
  DetailPage({required this.product});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DatabaseHelper _db = DatabaseHelper();
  bool isFav = false;
  bool inCart = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final fav = await _db.isFavorite(widget.product.id!);
    final cart = await _db.isInCart(widget.product.id!);
    setState(() {
      isFav = fav;
      inCart = cart;
    });
  }

  Future<void> _toggleFavorite() async {
    if (isFav) {
      await _db.removeFavorite(widget.product.id!);
    } else {
      await _db.addFavorite(widget.product);
    }
    setState(() => isFav = !isFav);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFav ? 'Ditambahkan ke Favorite' : 'Dihapus dari Favorite',
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> _addToCart() async {
    await _db.addToCart(widget.product);
    setState(() => inCart = true);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${widget.product.name} ditambahkan ke Keranjang'),
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Penanganan adaptif gambar untuk Detail
    Widget detailedImage;
    if (widget.product.image.startsWith('assets/')) {
      detailedImage = Image.asset(
        widget.product.image,
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => Icon(Icons.phone_android, size: 140, color: Colors.grey),
      );
    } else {
      detailedImage = Image.file(
        File(widget.product.image),
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => Icon(Icons.phone_android, size: 140, color: Colors.grey),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : Colors.black,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 280,
                    color: Colors.white,
                    child: Center(
                      child: detailedImage,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 4),
                            Text(
                              '${widget.product.rating}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '(${widget.product.reviews} reviews)',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(width: 12),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.orange.withOpacity(0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.circle, size: 10, color: Colors.orange),
                                  SizedBox(width: 4),
                                  Text(
                                    widget.product.color,
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          widget.product.price,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Deskripsi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Produk smartphone terbaik dengan spesifikasi tinggi dan performa maksimal. Tersedia dalam warna ${widget.product.color}. Dilengkapi kamera berkualitas tinggi dan baterai tahan lama.',
                          style: TextStyle(
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: inCart ? null : _addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: inCart ? Colors.grey : Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      inCart ? 'Sudah di Keranjang' : 'Tambah ke Keranjang',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// FAVORITE PAGE
// ================================================================
class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final DatabaseHelper _db = DatabaseHelper();
  List<Product> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final data = await _db.getFavorites();
    setState(() {
      favorites = data;
      isLoading = false;
    });
  }

  Future<void> _removeFavorite(int productId, int index) async {
    await _db.removeFavorite(productId);
    setState(() => favorites.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Produk dihapus dari Favorite'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Favorite', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.orange))
          : favorites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Belum ada produk favorit',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final product = favorites[index];

                    Widget favImage;
                    if (product.image.startsWith('assets/')) {
                      favImage = Image.asset(product.image, width: 60, height: 60, fit: BoxFit.contain);
                    } else {
                      favImage = Image.file(File(product.image), width: 60, height: 60, fit: BoxFit.contain);
                    }

                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          child: favImage,
                        ),
                        title: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.price, style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                            Text('Warna: ${product.color}', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeFavorite(product.id!, index),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

// ================================================================
// CART PAGE
// ================================================================
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final DatabaseHelper _db = DatabaseHelper();
  List<CartItem> cartItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final data = await _db.getCartItems();
    setState(() {
      cartItems = data;
      isLoading = false;
    });
  }

  int _calculateTotalPrice() {
    int total = 0;
    for (var item in cartItems) {
      int priceInt = int.tryParse(item.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      total += priceInt * item.quantity;
    }
    return total;
  }

  String _formatRupiah(int amount) {
    final s = amount.toString();
    final result = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if ((s.length - i) % 3 == 0 && i != 0) {
        result.write('.');
      }
      result.write(s[i]);
    }
    return 'Rp.$result';
  }

  Future<void> _updateQty(int productId, int currentQty, int delta) async {
    int newQty = currentQty + delta;
    await _db.updateCartQuantity(productId, newQty);
    await _loadCart();
  }

  Future<void> _checkout() async {
    if (cartItems.isEmpty) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Checkout Sukses'),
          ],
        ),
        content: Text('Terima kasih telah berbelanja! Pesanan Anda sedang diproses.'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _db.clearCart();
              Navigator.pop(ctx);
              _loadCart();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Keranjang Belanja', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.orange))
          : cartItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Keranjang Anda kosong', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];

                          Widget cartImage;
                          if (item.image.startsWith('assets/')) {
                            cartImage = Image.asset(item.image, width: 65, height: 65, fit: BoxFit.contain);
                          } else {
                            cartImage = Image.file(File(item.image), width: 65, height: 65, fit: BoxFit.contain);
                          }

                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 65,
                                    height: 65,
                                    child: cartImage,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                        SizedBox(height: 4),
                                        Text(item.price, style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                        SizedBox(height: 4),
                                        Text('Warna: ${item.color}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_circle_outline, color: Colors.orange, size: 22),
                                        onPressed: () => _updateQty(item.productId, item.quantity, -1),
                                      ),
                                      Text('${item.quantity}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: Icon(Icons.add_circle_outline, color: Colors.orange, size: 22),
                                        onPressed: () => _updateQty(item.productId, item.quantity, 1),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Pembayaran', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                Text(
                                  _formatRupiah(_calculateTotalPrice()),
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _checkout,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: Text('Checkout Sekarang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}

// ================================================================
// PROFILE PAGE
// ================================================================
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DatabaseHelper _db = DatabaseHelper();
  Map<String, dynamic>? profileData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final data = await _db.getProfile();
    setState(() {
      profileData = data;
      isLoading = false;
    });
  }

  void _editProfileDialog() {
    if (profileData == null) return;

    final nameCtrl = TextEditingController(text: profileData!['name']);
    final emailCtrl = TextEditingController(text: profileData!['email']);
    final addressCtrl = TextEditingController(text: profileData!['address'] ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Edit Profil'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Nama Lengkap')),
              SizedBox(height: 12),
              TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
              SizedBox(height: 12),
              TextField(controller: addressCtrl, decoration: InputDecoration(labelText: 'Alamat')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              await _db.updateProfile(
                nameCtrl.text.trim(),
                emailCtrl.text.trim(),
                addressCtrl.text.trim(),
              );
              Navigator.pop(ctx);
              _loadProfile();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.orange)));
    }

    final profile = profileData ?? {
      'name': 'Rifky Surya Pratama',
      'email': 'rifky@student.com',
      'address': 'Semarang, Indonesia',
      'vouchers': 5,
      'orders': 12,
      'reviews': 8
    };

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Profil Saya', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: _editProfileDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.orange,
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 32, top: 16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 60, color: Colors.orange),
                  ),
                  SizedBox(height: 16),
                  Text(
                    profile['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 6),
                  Text(
                    profile['email'],
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.white70),
                      SizedBox(width: 4),
                      Text(
                        profile['address'] ?? 'Belum diatur',
                        style: TextStyle(fontSize: 13, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn('Voucher', '${profile['vouchers']}'),
                  _buildStatColumn('Pesanan', '${profile['orders']}'),
                  _buildStatColumn('Ulasan', '${profile['reviews']}'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildMenuTile(Icons.shopping_bag_outlined, 'Riwayat Transaksi'),
                  _buildMenuTile(Icons.payment_outlined, 'Metode Pembayaran'),
                  _buildMenuTile(Icons.privacy_tip_outlined, 'Keamanan Akun'),
                  _buildMenuTile(Icons.help_outline, 'Pusat Bantuan'),
                  SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text('Keluar Akun', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildMenuTile(IconData icon, String title) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
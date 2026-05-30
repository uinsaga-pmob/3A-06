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
          style: TextStyle(color: Colors.black, fontSize: 16),
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
              _loadProducts(); // refresh setelah kembali
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
<<<<<<< HEAD
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
=======
                                      color: Colors.white70, fontSize: 14),
>>>>>>> 4cdc423 (Update project)
                                ),
                              ],
                            ),
                          ),
<<<<<<< HEAD
                          Icon(
                            Icons.phone_android,
                            color: Colors.white,
                            size: 50,
                          ),
=======
                          Icon(Icons.phone_android,
                              color: Colors.white, size: 50),
>>>>>>> 4cdc423 (Update project)
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
<<<<<<< HEAD
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
=======
                                fontSize: 16, fontWeight: FontWeight.bold),
>>>>>>> 4cdc423 (Update project)
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
<<<<<<< HEAD
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
=======
                                    Icon(Icons.inventory_2_outlined,
                                        size: 60, color: Colors.grey),
                                    SizedBox(height: 12),
                                    Text('Belum ada produk',
                                        style: TextStyle(color: Colors.grey)),
>>>>>>> 4cdc423 (Update project)
                                    SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
<<<<<<< HEAD
                                            builder: (_) => ManageProductPage(),
                                          ),
=======
                                              builder: (_) =>
                                                  ManageProductPage()),
>>>>>>> 4cdc423 (Update project)
                                        );
                                        _loadProducts();
                                      },
                                      style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                                        backgroundColor: Colors.orange,
                                      ),
=======
                                          backgroundColor: Colors.orange),
>>>>>>> 4cdc423 (Update project)
                                      child: Text('Tambah Produk'),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
<<<<<<< HEAD
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.68,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
=======
                                crossAxisCount: 2,
                                childAspectRatio: 0.68,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
>>>>>>> 4cdc423 (Update project)
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  product: products[index],
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DetailPage(
<<<<<<< HEAD
                                          product: products[index],
                                        ),
=======
                                            product: products[index]),
>>>>>>> 4cdc423 (Update project)
                                      ),
                                    );
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
<<<<<<< HEAD
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FavoritePage()),
            ).then((_) => setState(() => _currentIndex = 0));
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartPage()),
            ).then((_) => setState(() => _currentIndex = 0));
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfilePage()),
            ).then((_) => setState(() => _currentIndex = 0));
=======
            Navigator.push(context,
                    MaterialPageRoute(builder: (_) => FavoritePage()))
                .then((_) => setState(() => _currentIndex = 0));
          } else if (index == 2) {
            Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartPage()))
                .then((_) => setState(() => _currentIndex = 0));
          } else if (index == 3) {
            Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ProfilePage()))
                .then((_) => setState(() => _currentIndex = 0));
>>>>>>> 4cdc423 (Update project)
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
// PRODUCT CARD WIDGET — tampilkan warna
// ================================================================
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
<<<<<<< HEAD
                    return Icon(
                      Icons.phone_android,
                      size: 70,
                      color: Colors.grey,
                    );
=======
                    return Icon(Icons.phone_android,
                        size: 70, color: Colors.grey);
>>>>>>> 4cdc423 (Update project)
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
<<<<<<< HEAD
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
=======
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
>>>>>>> 4cdc423 (Update project)
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
<<<<<<< HEAD
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
=======
                        style:
                            TextStyle(fontSize: 11, color: Colors.grey[600]),
>>>>>>> 4cdc423 (Update project)
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
<<<<<<< HEAD
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
=======
                    padding:
                        EdgeInsets.symmetric(horizontal: 6, vertical: 2),
>>>>>>> 4cdc423 (Update project)
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product.color,
<<<<<<< HEAD
                      style: TextStyle(fontSize: 10, color: Colors.orange[700]),
=======
                      style:
                          TextStyle(fontSize: 10, color: Colors.orange[700]),
>>>>>>> 4cdc423 (Update project)
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
<<<<<<< HEAD
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFav ? 'Ditambahkan ke Favorite' : 'Dihapus dari Favorite',
        ),
        duration: Duration(seconds: 1),
      ),
    );
=======
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          isFav ? 'Ditambahkan ke Favorite' : 'Dihapus dari Favorite'),
      duration: Duration(seconds: 1),
    ));
>>>>>>> 4cdc423 (Update project)
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
                      child: Image.asset(
                        widget.product.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
<<<<<<< HEAD
                          return Icon(
                            Icons.phone_android,
                            size: 140,
                            color: Colors.grey,
                          );
=======
                          return Icon(Icons.phone_android,
                              size: 140, color: Colors.grey);
>>>>>>> 4cdc423 (Update project)
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
<<<<<<< HEAD
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
=======
                        Text(widget.product.name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
>>>>>>> 4cdc423 (Update project)
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
<<<<<<< HEAD
                            Text(
                              '(${widget.product.reviews} reviews)',
                              style: TextStyle(color: Colors.grey),
                            ),
=======
                            Text('(${widget.product.reviews} reviews)',
                                style: TextStyle(color: Colors.grey)),
>>>>>>> 4cdc423 (Update project)
                            SizedBox(width: 12),
                            // Badge warna
                            Container(
                              padding: EdgeInsets.symmetric(
<<<<<<< HEAD
                                horizontal: 8,
                                vertical: 4,
                              ),
=======
                                  horizontal: 8, vertical: 4),
>>>>>>> 4cdc423 (Update project)
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
<<<<<<< HEAD
                                  color: Colors.orange.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    widget.product.color,
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 12,
                                    ),
                                  ),
=======
                                    color: Colors.orange.withOpacity(0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.circle,
                                      size: 10, color: Colors.orange),
                                  SizedBox(width: 4),
                                  Text(widget.product.color,
                                      style: TextStyle(
                                          color: Colors.orange, fontSize: 12)),
>>>>>>> 4cdc423 (Update project)
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
<<<<<<< HEAD
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
=======
                        Text(widget.product.price,
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange)),
                        SizedBox(height: 16),
                        Text('Deskripsi',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text(
                          'Produk smartphone terbaik dengan spesifikasi tinggi dan performa maksimal. Tersedia dalam warna ${widget.product.color}. Dilengkapi kamera berkualitas tinggi dan baterai tahan lama.',
                          style:
                              TextStyle(color: Colors.grey[700], height: 1.5),
>>>>>>> 4cdc423 (Update project)
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
<<<<<<< HEAD
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
=======
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2))
>>>>>>> 4cdc423 (Update project)
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
        title:
            Text('Favorite', style: TextStyle(color: Colors.black)),
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
<<<<<<< HEAD
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      product.image,
                      width: 60,
                      errorBuilder: (c, e, s) =>
                          Icon(Icons.phone_android, size: 40),
                    ),
                    title: Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.price,
                          style: TextStyle(color: Colors.orange),
                        ),
                        Text(
                          'Warna: ${product.color}',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
=======
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final product = favorites[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: Image.asset(
                          product.image,
                          width: 60,
                          errorBuilder: (c, e, s) =>
                              Icon(Icons.phone_android, size: 40),
                        ),
                        title: Text(product.name,
                            style:
                                TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.price,
                                style: TextStyle(color: Colors.orange)),
                            Text('Warna: ${product.color}',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              _removeFavorite(product.id!, index),
>>>>>>> 4cdc423 (Update project)
                        ),
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

  Future<void> _updateQuantity(int productId, int qty, int index) async {
    await _db.updateCartQuantity(productId, qty);
    if (qty <= 0) {
      setState(() => cartItems.removeAt(index));
    } else {
      setState(() => cartItems[index].quantity = qty);
    }
  }

  int get _totalPrice => cartItems.fold(0, (sum, item) => sum + item.subtotal);

  String get _totalFormatted {
    final total = _totalPrice;
    final s = total.toString();
    final result = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if ((s.length - i) % 3 == 0 && i != 0) result.write('.');
      result.write(s[i]);
    }
    return 'Rp.$result';
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
        title: Text('My Cart', style: TextStyle(color: Colors.black)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.orange))
          : cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
<<<<<<< HEAD
                  SizedBox(height: 16),
                  Text(
                    'Keranjang masih kosong',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
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
                      return Card(
                        margin: EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Image.asset(
                                item.image,
                                width: 65,
                                height: 65,
                                errorBuilder: (c, e, s) =>
                                    Icon(Icons.phone_android, size: 50),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      item.price,
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      'Warna: ${item.color}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      size: 22,
                                    ),
                                    onPressed: () => _updateQuantity(
                                      item.productId,
                                      item.quantity - 1,
                                      index,
                                    ),
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.orange,
                                      size: 22,
                                    ),
                                    onPressed: () => _updateQuantity(
                                      item.productId,
                                      item.quantity + 1,
                                      index,
                                    ),
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
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:', style: TextStyle(fontSize: 18)),
                          Text(
                            _totalFormatted,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
=======
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Image.asset(
                                    item.image,
                                    width: 65,
                                    height: 65,
                                    errorBuilder: (c, e, s) => Icon(
                                        Icons.phone_android,
                                        size: 50),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item.name,
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.bold,
                                                fontSize: 13)),
                                        SizedBox(height: 2),
                                        Text(item.price,
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 13)),
                                        Text('Warna: ${item.color}',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                            Icons.remove_circle_outline,
                                            size: 22),
                                        onPressed: () =>
                                            _updateQuantity(
                                                item.productId,
                                                item.quantity - 1,
                                                index),
                                      ),
                                      Text('${item.quantity}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      IconButton(
                                        icon: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.orange,
                                            size: 22),
                                        onPressed: () =>
                                            _updateQuantity(
                                                item.productId,
                                                item.quantity + 1,
                                                index),
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
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, -2))
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total:',
                                  style: TextStyle(fontSize: 18)),
                              Text(_totalFormatted,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange)),
                            ],
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CheckoutPage(
                                      cartItems: cartItems,
                                      total: _totalFormatted,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding:
                                    EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8)),
                              ),
                              child: Text('Checkout',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
>>>>>>> 4cdc423 (Update project)
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutPage(
                                  cartItems: cartItems,
                                  total: _totalFormatted,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Checkout',
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
// CHECKOUT PAGE
// ================================================================
class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final String total;
  CheckoutPage({required this.cartItems, required this.total});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedPayment = 1;
  final DatabaseHelper _db = DatabaseHelper();

  int get _ongkir => 15000;
  int get _subtotalInt =>
      widget.cartItems.fold(0, (sum, item) => sum + item.subtotal);
  int get _grandTotal => _subtotalInt + _ongkir;

  String _formatRupiah(int amount) {
    final s = amount.toString();
    final result = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if ((s.length - i) % 3 == 0 && i != 0) result.write('.');
      result.write(s[i]);
    }
    return 'Rp.$result';
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
        title: Text('Check Out', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery Address',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(
<<<<<<< HEAD
                  borderRadius: BorderRadius.circular(12),
                ),
=======
                    borderRadius: BorderRadius.circular(12)),
>>>>>>> 4cdc423 (Update project)
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rifky',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text('Jl. Contoh No. 123, Jakarta Selatan'),
                      Text('Jakarta, DKI Jakarta, 12345'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(
<<<<<<< HEAD
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
=======
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    _buildPaymentOption(
                        1, Icons.account_balance, 'DANA', Colors.blue),
>>>>>>> 4cdc423 (Update project)
                    _buildPaymentOption(
                      1,
                      Icons.account_balance,
                      'DANA',
                      Colors.blue,
                    ),
                    _buildPaymentOption(
                      2,
                      Icons.payment,
                      'Gopay',
                      Colors.green,
                    ),
                    _buildPaymentOption(
                      3,
                      Icons.account_balance_wallet,
                      'OVO',
                      Colors.purple,
                    ),
                    _buildPaymentOption(
                      4,
                      Icons.credit_card,
                      'ShopeePay',
                      Colors.orange,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
<<<<<<< HEAD
                  borderRadius: BorderRadius.circular(12),
                ),
=======
                    borderRadius: BorderRadius.circular(12)),
>>>>>>> 4cdc423 (Update project)
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            _formatRupiah(_subtotalInt),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ongkir', style: TextStyle(color: Colors.white)),
                          Text(
                            _formatRupiah(_ongkir),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white54),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            _formatRupiah(_grandTotal),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await _db.clearCart();
                    Navigator.push(
                      context,
<<<<<<< HEAD
                      MaterialPageRoute(builder: (_) => PaymentSuccessPage()),
=======
                      MaterialPageRoute(
                          builder: (_) => PaymentSuccessPage()),
>>>>>>> 4cdc423 (Update project)
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Bayar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    int value,
    IconData icon,
    String label,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label),
      trailing: Radio<int>(
        value: value,
        groupValue: _selectedPayment,
        activeColor: Colors.orange,
        onChanged: (val) => setState(() => _selectedPayment = val!),
      ),
    );
  }
}

// ================================================================
// PAYMENT SUCCESS PAGE
// ================================================================
class PaymentSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.orange, size: 100),
              SizedBox(height: 24),
<<<<<<< HEAD
              Text(
                'Hooray! Payment Successful!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
=======
              Text('Hooray! Payment Successful!',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
>>>>>>> 4cdc423 (Update project)
              SizedBox(height: 12),
              Text('Your payment has been successfully done.',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).popUntil((r) => r.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Kembali ke Home',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
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
  UserProfile? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final data = await _db.getProfile();
    setState(() {
      if (data != null) profile = UserProfile.fromMap(data);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.orange))
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.orangeAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          IconButton(
<<<<<<< HEAD
                            icon: Icon(Icons.arrow_back, color: Colors.white),
=======
                            icon:
                                Icon(Icons.arrow_back, color: Colors.white),
>>>>>>> 4cdc423 (Update project)
                            onPressed: () => Navigator.pop(context),
                          ),
                          Spacer(),
                          Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
<<<<<<< HEAD
                      child: Icon(Icons.person, size: 60, color: Colors.orange),
                    ),
                    SizedBox(height: 16),
                    Text(
                      profile?.name ?? '-',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      profile?.email ?? '-',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
=======
                      child: Icon(Icons.person,
                          size: 60, color: Colors.orange),
                    ),
                    SizedBox(height: 16),
                    Text(profile?.name ?? '-',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(profile?.email ?? '-',
                        style:
                            TextStyle(color: Colors.white70, fontSize: 14)),
>>>>>>> 4cdc423 (Update project)
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard('${profile?.vouchers ?? 0}', 'Vouchers'),
                        _buildStatCard('${profile?.orders ?? 0}', 'Pesanan'),
                        _buildStatCard('${profile?.reviews ?? 0}', 'Ulasan'),
                      ],
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: ListView(
                          padding: EdgeInsets.all(16),
                          children: [
                            _buildMenuItem(
                              Icons.person_outline,
                              'Account',
                              () {},
                            ),
                            _buildMenuItem(
                              Icons.location_on_outlined,
                              'Address',
                              () {},
                            ),
                            _buildMenuItem(
                              Icons.receipt_outlined,
                              'Transaction',
                              () {},
                            ),
                            _buildMenuItem(
                              Icons.help_outline,
                              'Help Center',
                              () {},
                            ),
                            _buildMenuItem(Icons.logout, 'Logout', () {}),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildStatCard(String count, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

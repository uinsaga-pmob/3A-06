import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'product_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'toko_hp.db');
      print('DEBUG DB PATH: $path');

      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
    } catch (e) {
      print('DEBUG INIT ERROR: $e');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    print('DEBUG: Membuat tabel...');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price TEXT NOT NULL,
        image TEXT NOT NULL,
        rating REAL DEFAULT 4.5,
        reviews INTEGER DEFAULT 120
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        price TEXT NOT NULL,
        image TEXT NOT NULL,
        rating REAL DEFAULT 4.5,
        reviews INTEGER DEFAULT 120,
        UNIQUE(product_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        price TEXT NOT NULL,
        image TEXT NOT NULL,
        rating REAL DEFAULT 4.5,
        reviews INTEGER DEFAULT 120,
        quantity INTEGER DEFAULT 1,
        UNIQUE(product_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS profile (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        address TEXT,
        vouchers INTEGER DEFAULT 0,
        orders INTEGER DEFAULT 0,
        reviews INTEGER DEFAULT 0
      )
    ''');

    print('DEBUG: Tabel berhasil dibuat, mulai seed data...');
    await _seedData(db);
    print('DEBUG: Seed data selesai');
  }

  Future<void> _seedData(Database db) async {
    final List<Map<String, dynamic>> productList = [
      {'name': 'IPhone 12 Pro',        'price': 'Rp.9.000.000',  'image': 'assets/images/12pro.png',                 'rating': 4.8, 'reviews': 230},
      {'name': 'Iphone 11',            'price': 'Rp.8.500.000',  'image': 'assets/images/iphone11.png',              'rating': 4.7, 'reviews': 310},
      {'name': 'IPhone 13',            'price': 'Rp.12.000.000', 'image': 'assets/images/iphone13.jpeg',             'rating': 4.9, 'reviews': 415},
      {'name': 'Iphone 13 pro',        'price': 'Rp.13.500.000', 'image': 'assets/images/iphone13pro.jpg',           'rating': 4.9, 'reviews': 502},
      {'name': 'Iphone XR',            'price': 'Rp.6.999.000',  'image': 'assets/images/iphonexr.jpg',              'rating': 4.5, 'reviews': 178},
      {'name': 'MI 11 256GB',          'price': 'Rp.8.000.000',  'image': 'assets/images/mi 11.png',                 'rating': 4.6, 'reviews': 145},
      {'name': 'Poco F4 GT NFC',       'price': 'Rp.7.999.999',  'image': 'assets/images/poco f4 GT NFC.webp',       'rating': 4.7, 'reviews': 198},
      {'name': 'Redmi note 12 pro 5G', 'price': 'Rp.4.500.000',  'image': 'assets/images/redmi note 12 pro 5G.webp', 'rating': 4.5, 'reviews': 265},
      {'name': 'Poco X5 5G',           'price': 'Rp.3.599.999',  'image': 'assets/images/poco X5 5G.png',            'rating': 4.4, 'reviews': 112},
      {'name': 'Realme 9 5G',          'price': 'Rp.2.799.999',  'image': 'assets/images/Realme 9 5G.png',           'rating': 4.3, 'reviews': 89},
      {'name': 'Realme 9 Pro',         'price': 'Rp.3.399.000',  'image': 'assets/images/Realme 9 Pro.jpg',          'rating': 4.4, 'reviews': 134},
      {'name': 'Realme 9i',            'price': 'Rp.2.899.000',  'image': 'assets/images/Realme 9i.webp',            'rating': 4.2, 'reviews': 77},
      {'name': 'Realme GT NEO 3',      'price': 'Rp.5.999.999',  'image': 'assets/images/realme GT NEO 3.jpg',       'rating': 4.6, 'reviews': 201},
    ];

    for (var p in productList) {
      await db.insert('products', p);
    }

    await db.insert('profile', {
      'name': 'Rifky Surya Pratama',
      'email': 'rifkysurya@gmail.com',
      'address': 'Jl. Contoh No. 123, Jakarta Selatan',
      'vouchers': 12,
      'orders': 8,
      'reviews': 3,
    });
  }

  // ==================== PRODUCTS ====================
  Future<List<Product>> getAllProducts() async {
    try {
      final db = await database;
      final maps = await db.query('products');
      print('DEBUG getAllProducts: ${maps.length} produk ditemukan');
      return maps.map((m) => Product.fromMap(m)).toList();
    } catch (e) {
      print('DEBUG getAllProducts ERROR: $e');
      return [];
    }
  }

  // ==================== FAVORITES ====================
  Future<List<Product>> getFavorites() async {
    try {
      final db = await database;
      final maps = await db.query('favorites');
      return maps.map((m) => Product.fromMap(m, idKey: 'product_id')).toList();
    } catch (e) {
      print('DEBUG getFavorites ERROR: $e');
      return [];
    }
  }

  Future<bool> isFavorite(int productId) async {
    try {
      final db = await database;
      final result = await db.query(
        'favorites',
        where: 'product_id = ?',
        whereArgs: [productId],
      );
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> addFavorite(Product product) async {
    try {
      final db = await database;
      await db.insert(
        'favorites',
        {
          'product_id': product.id,
          'name': product.name,
          'price': product.price,
          'image': product.image,
          'rating': product.rating,
          'reviews': product.reviews,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } catch (e) {
      print('DEBUG addFavorite ERROR: $e');
    }
  }

  Future<void> removeFavorite(int productId) async {
    try {
      final db = await database;
      await db.delete('favorites', where: 'product_id = ?', whereArgs: [productId]);
    } catch (e) {
      print('DEBUG removeFavorite ERROR: $e');
    }
  }

  // ==================== CART ====================
  Future<List<CartItem>> getCartItems() async {
    try {
      final db = await database;
      final maps = await db.query('cart');
      return maps.map((m) => CartItem.fromMap(m)).toList();
    } catch (e) {
      print('DEBUG getCartItems ERROR: $e');
      return [];
    }
  }

  Future<bool> isInCart(int productId) async {
    try {
      final db = await database;
      final result = await db.query(
        'cart',
        where: 'product_id = ?',
        whereArgs: [productId],
      );
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> addToCart(Product product) async {
    try {
      final db = await database;
      final existing = await db.query(
        'cart',
        where: 'product_id = ?',
        whereArgs: [product.id],
      );
      if (existing.isNotEmpty) {
        final currentQty = existing.first['quantity'] as int;
        await db.update(
          'cart',
          {'quantity': currentQty + 1},
          where: 'product_id = ?',
          whereArgs: [product.id],
        );
      } else {
        await db.insert('cart', {
          'product_id': product.id,
          'name': product.name,
          'price': product.price,
          'image': product.image,
          'rating': product.rating,
          'reviews': product.reviews,
          'quantity': 1,
        });
      }
    } catch (e) {
      print('DEBUG addToCart ERROR: $e');
    }
  }

  Future<void> updateCartQuantity(int productId, int quantity) async {
    try {
      final db = await database;
      if (quantity <= 0) {
        await removeFromCart(productId);
      } else {
        await db.update(
          'cart',
          {'quantity': quantity},
          where: 'product_id = ?',
          whereArgs: [productId],
        );
      }
    } catch (e) {
      print('DEBUG updateCartQuantity ERROR: $e');
    }
  }

  Future<void> removeFromCart(int productId) async {
    try {
      final db = await database;
      await db.delete('cart', where: 'product_id = ?', whereArgs: [productId]);
    } catch (e) {
      print('DEBUG removeFromCart ERROR: $e');
    }
  }

  Future<void> clearCart() async {
    try {
      final db = await database;
      await db.delete('cart');
    } catch (e) {
      print('DEBUG clearCart ERROR: $e');
    }
  }

  // ==================== PROFILE ====================
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final db = await database;
      final maps = await db.query('profile', limit: 1);
      if (maps.isEmpty) return null;
      return maps.first;
    } catch (e) {
      print('DEBUG getProfile ERROR: $e');
      return null;
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      final db = await database;
      await db.update('profile', data, where: 'id = ?', whereArgs: [1]);
    } catch (e) {
      print('DEBUG updateProfile ERROR: $e');
    }
  }
}
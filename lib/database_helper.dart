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
      return await openDatabase(
        path,
        version: 2, // versi naik karena ada kolom baru
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      print('DEBUG INIT ERROR: $e');
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price TEXT NOT NULL,
        image TEXT NOT NULL,
        rating REAL DEFAULT 4.5,
        reviews INTEGER DEFAULT 120,
        color TEXT DEFAULT 'Hitam'
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
        color TEXT DEFAULT 'Hitam',
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
        color TEXT DEFAULT 'Hitam',
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

    await _seedData(db);
  }

  // Upgrade database jika sudah ada versi lama
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Tambah kolom color jika belum ada
      try {
<<<<<<< HEAD
        await db.execute(
          "ALTER TABLE products ADD COLUMN color TEXT DEFAULT 'Hitam'",
        );
      } catch (e) {
        print('color sudah ada di products');
      }
      try {
        await db.execute(
          "ALTER TABLE favorites ADD COLUMN color TEXT DEFAULT 'Hitam'",
        );
      } catch (e) {
        print('color sudah ada di favorites');
      }
      try {
        await db.execute(
          "ALTER TABLE cart ADD COLUMN color TEXT DEFAULT 'Hitam'",
        );
      } catch (e) {
        print('color sudah ada di cart');
      }
=======
        await db.execute("ALTER TABLE products ADD COLUMN color TEXT DEFAULT 'Hitam'");
      } catch (e) { print('color sudah ada di products'); }
      try {
        await db.execute("ALTER TABLE favorites ADD COLUMN color TEXT DEFAULT 'Hitam'");
      } catch (e) { print('color sudah ada di favorites'); }
      try {
        await db.execute("ALTER TABLE cart ADD COLUMN color TEXT DEFAULT 'Hitam'");
      } catch (e) { print('color sudah ada di cart'); }
>>>>>>> 4cdc423 (Update project)
    }
  }

  Future<void> _seedData(Database db) async {
    final List<Map<String, dynamic>> productList = [
<<<<<<< HEAD
      {
        'name': 'IPhone 12 Pro',
        'price': 'Rp.9.000.000',
        'image': 'assets/images/12pro.png',
        'rating': 4.8,
        'reviews': 230,
        'color': 'Silver',
      },
      {
        'name': 'Iphone 11',
        'price': 'Rp.8.500.000',
        'image': 'assets/images/iphone11.png',
        'rating': 4.7,
        'reviews': 310,
        'color': 'Purple',
      },
      {
        'name': 'IPhone 13',
        'price': 'Rp.12.000.000',
        'image': 'assets/images/iphone13.jpeg',
        'rating': 4.9,
        'reviews': 415,
        'color': 'Midnight',
      },
      {
        'name': 'Iphone 13 pro',
        'price': 'Rp.13.500.000',
        'image': 'assets/images/iphone13pro.jpg',
        'rating': 4.9,
        'reviews': 502,
        'color': 'Gold',
      },
      {
        'name': 'Iphone XR',
        'price': 'Rp.6.999.000',
        'image': 'assets/images/iphonexr.jpg',
        'rating': 4.5,
        'reviews': 178,
        'color': 'Coral',
      },
      {
        'name': 'MI 11 256GB',
        'price': 'Rp.8.000.000',
        'image': 'assets/images/mi 11.png',
        'rating': 4.6,
        'reviews': 145,
        'color': 'Biru',
      },
      {
        'name': 'Poco F4 GT NFC',
        'price': 'Rp.7.999.999',
        'image': 'assets/images/poco f4 GT NFC.webp',
        'rating': 4.7,
        'reviews': 198,
        'color': 'Hitam',
      },
      {
        'name': 'Redmi note 12 pro 5G',
        'price': 'Rp.4.500.000',
        'image': 'assets/images/redmi note 12 pro 5G.webp',
        'rating': 4.5,
        'reviews': 265,
        'color': 'Putih',
      },
      {
        'name': 'Poco X5 5G',
        'price': 'Rp.3.599.999',
        'image': 'assets/images/poco X5 5G.png',
        'rating': 4.4,
        'reviews': 112,
        'color': 'Hitam',
      },
      {
        'name': 'Realme 9 5G',
        'price': 'Rp.2.799.999',
        'image': 'assets/images/Realme 9 5G.png',
        'rating': 4.3,
        'reviews': 89,
        'color': 'Biru',
      },
      {
        'name': 'Realme 9 Pro',
        'price': 'Rp.3.399.000',
        'image': 'assets/images/Realme 9 Pro.jpg',
        'rating': 4.4,
        'reviews': 134,
        'color': 'Hijau',
      },
      {
        'name': 'Realme 9i',
        'price': 'Rp.2.899.000',
        'image': 'assets/images/Realme 9i.webp',
        'rating': 4.2,
        'reviews': 77,
        'color': 'Biru',
      },
      {
        'name': 'Realme GT NEO 3',
        'price': 'Rp.5.999.999',
        'image': 'assets/images/realme GT NEO 3.jpg',
        'rating': 4.6,
        'reviews': 201,
        'color': 'Hitam',
      },
=======
      {'name': 'IPhone 12 Pro',        'price': 'Rp.9.000.000',  'image': 'assets/images/12pro.png',                 'rating': 4.8, 'reviews': 230, 'color': 'Silver'},
      {'name': 'Iphone 11',            'price': 'Rp.8.500.000',  'image': 'assets/images/iphone11.png',              'rating': 4.7, 'reviews': 310, 'color': 'Purple'},
      {'name': 'IPhone 13',            'price': 'Rp.12.000.000', 'image': 'assets/images/iphone13.jpeg',             'rating': 4.9, 'reviews': 415, 'color': 'Midnight'},
      {'name': 'Iphone 13 pro',        'price': 'Rp.13.500.000', 'image': 'assets/images/iphone13pro.jpg',           'rating': 4.9, 'reviews': 502, 'color': 'Gold'},
      {'name': 'Iphone XR',            'price': 'Rp.6.999.000',  'image': 'assets/images/iphonexr.jpg',              'rating': 4.5, 'reviews': 178, 'color': 'Coral'},
      {'name': 'MI 11 256GB',          'price': 'Rp.8.000.000',  'image': 'assets/images/mi 11.png',                 'rating': 4.6, 'reviews': 145, 'color': 'Biru'},
      {'name': 'Poco F4 GT NFC',       'price': 'Rp.7.999.999',  'image': 'assets/images/poco f4 GT NFC.webp',       'rating': 4.7, 'reviews': 198, 'color': 'Hitam'},
      {'name': 'Redmi note 12 pro 5G', 'price': 'Rp.4.500.000',  'image': 'assets/images/redmi note 12 pro 5G.webp', 'rating': 4.5, 'reviews': 265, 'color': 'Putih'},
      {'name': 'Poco X5 5G',           'price': 'Rp.3.599.999',  'image': 'assets/images/poco X5 5G.png',            'rating': 4.4, 'reviews': 112, 'color': 'Hitam'},
      {'name': 'Realme 9 5G',          'price': 'Rp.2.799.999',  'image': 'assets/images/Realme 9 5G.png',           'rating': 4.3, 'reviews': 89,  'color': 'Biru'},
      {'name': 'Realme 9 Pro',         'price': 'Rp.3.399.000',  'image': 'assets/images/Realme 9 Pro.jpg',          'rating': 4.4, 'reviews': 134, 'color': 'Hijau'},
      {'name': 'Realme 9i',            'price': 'Rp.2.899.000',  'image': 'assets/images/Realme 9i.webp',            'rating': 4.2, 'reviews': 77,  'color': 'Biru'},
      {'name': 'Realme GT NEO 3',      'price': 'Rp.5.999.999',  'image': 'assets/images/realme GT NEO 3.jpg',       'rating': 4.6, 'reviews': 201, 'color': 'Hitam'},
>>>>>>> 4cdc423 (Update project)
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

  // ==================== PRODUCTS CRUD ====================
  Future<List<Product>> getAllProducts() async {
    try {
      final db = await database;
      final maps = await db.query('products');
      return maps.map((m) => Product.fromMap(m)).toList();
    } catch (e) {
      print('DEBUG getAllProducts ERROR: $e');
      return [];
    }
  }

  Future<int> insertProduct(Product product) async {
    try {
      final db = await database;
      return await db.insert('products', product.toMap());
    } catch (e) {
      print('DEBUG insertProduct ERROR: $e');
      return -1;
    }
  }

  Future<int> updateProduct(Product product) async {
    try {
      final db = await database;
      return await db.update(
        'products',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
    } catch (e) {
      print('DEBUG updateProduct ERROR: $e');
      return -1;
    }
  }

  Future<int> deleteProduct(int id) async {
    try {
      final db = await database;
      // hapus juga dari cart & favorites
      await db.delete('cart', where: 'product_id = ?', whereArgs: [id]);
      await db.delete('favorites', where: 'product_id = ?', whereArgs: [id]);
      return await db.delete('products', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('DEBUG deleteProduct ERROR: $e');
      return -1;
    }
  }

  // ==================== FAVORITES ====================
  Future<List<Product>> getFavorites() async {
    try {
      final db = await database;
      final maps = await db.query('favorites');
      return maps.map((m) => Product.fromMap(m, idKey: 'product_id')).toList();
<<<<<<< HEAD
    } catch (e) {
      return [];
    }
=======
    } catch (e) { return []; }
>>>>>>> 4cdc423 (Update project)
  }

  Future<bool> isFavorite(int productId) async {
    try {
      final db = await database;
      final result = await db.query('favorites', where: 'product_id = ?', whereArgs: [productId]);
      return result.isNotEmpty;
    } catch (e) { return false; }
  }

  Future<void> addFavorite(Product product) async {
    try {
      final db = await database;
      await db.insert('favorites', {
        'product_id': product.id,
        'name': product.name,
        'price': product.price,
        'image': product.image,
        'rating': product.rating,
        'reviews': product.reviews,
        'color': product.color,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
<<<<<<< HEAD
    } catch (e) {
      print('DEBUG addFavorite ERROR: $e');
    }
=======
    } catch (e) { print('DEBUG addFavorite ERROR: $e'); }
>>>>>>> 4cdc423 (Update project)
  }

  Future<void> removeFavorite(int productId) async {
    try {
      final db = await database;
<<<<<<< HEAD
      await db.delete(
        'favorites',
        where: 'product_id = ?',
        whereArgs: [productId],
      );
    } catch (e) {
      print('DEBUG removeFavorite ERROR: $e');
    }
=======
      await db.delete('favorites', where: 'product_id = ?', whereArgs: [productId]);
    } catch (e) { print('DEBUG removeFavorite ERROR: $e'); }
>>>>>>> 4cdc423 (Update project)
  }

  // ==================== CART ====================
  Future<List<CartItem>> getCartItems() async {
    try {
      final db = await database;
      final maps = await db.query('cart');
      return maps.map((m) => CartItem.fromMap(m)).toList();
<<<<<<< HEAD
    } catch (e) {
      return [];
    }
=======
    } catch (e) { return []; }
>>>>>>> 4cdc423 (Update project)
  }

  Future<bool> isInCart(int productId) async {
    try {
      final db = await database;
      final result = await db.query('cart', where: 'product_id = ?', whereArgs: [productId]);
      return result.isNotEmpty;
    } catch (e) { return false; }
  }

  Future<void> addToCart(Product product) async {
    try {
      final db = await database;
      final existing = await db.query('cart', where: 'product_id = ?', whereArgs: [product.id]);
      if (existing.isNotEmpty) {
        final currentQty = existing.first['quantity'] as int;
        await db.update('cart', {'quantity': currentQty + 1},
            where: 'product_id = ?', whereArgs: [product.id]);
      } else {
        await db.insert('cart', {
          'product_id': product.id,
          'name': product.name,
          'price': product.price,
          'image': product.image,
          'rating': product.rating,
          'reviews': product.reviews,
          'color': product.color,
          'quantity': 1,
        });
      }
    } catch (e) { print('DEBUG addToCart ERROR: $e'); }
  }

  Future<void> updateCartQuantity(int productId, int quantity) async {
    try {
      final db = await database;
      if (quantity <= 0) {
        await removeFromCart(productId);
      } else {
        await db.update('cart', {'quantity': quantity},
            where: 'product_id = ?', whereArgs: [productId]);
      }
    } catch (e) { print('DEBUG updateCartQuantity ERROR: $e'); }
  }

  Future<void> removeFromCart(int productId) async {
    try {
      final db = await database;
      await db.delete('cart', where: 'product_id = ?', whereArgs: [productId]);
    } catch (e) { print('DEBUG removeFromCart ERROR: $e'); }
  }

  Future<void> clearCart() async {
    try {
      final db = await database;
      await db.delete('cart');
    } catch (e) { print('DEBUG clearCart ERROR: $e'); }
  }

  // ==================== PROFILE ====================
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final db = await database;
      final maps = await db.query('profile', limit: 1);
      if (maps.isEmpty) return null;
      return maps.first;
<<<<<<< HEAD
    } catch (e) {
      return null;
    }
=======
    } catch (e) { return null; }
>>>>>>> 4cdc423 (Update project)
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      final db = await database;
      await db.update('profile', data, where: 'id = ?', whereArgs: [1]);
    } catch (e) { print('DEBUG updateProfile ERROR: $e'); }
  }
}

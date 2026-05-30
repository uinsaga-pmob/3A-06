import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'product_model.dart';

// ================================================================
// HALAMAN KELOLA PRODUK (List + Tambah + Edit + Hapus)
// ================================================================
class ManageProductPage extends StatefulWidget {
  @override
  _ManageProductPageState createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  final DatabaseHelper _db = DatabaseHelper();
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => isLoading = true);
    final data = await _db.getAllProducts();
    setState(() {
      products = data;
      isLoading = false;
    });
  }

  Future<void> _deleteProduct(Product product) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('Hapus Produk'),
          ],
        ),
        content: Text(
          'Yakin ingin menghapus "${product.name}"?\nProduk juga akan dihapus dari Cart dan Favorite.',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _db.deleteProduct(product.id!);
      await _loadProducts();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} berhasil dihapus'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _openForm({Product? product}) async {
    final result = await Navigator.push(
      context,
<<<<<<< HEAD
      MaterialPageRoute(builder: (_) => ProductFormPage(product: product)),
=======
      MaterialPageRoute(
        builder: (_) => ProductFormPage(product: product),
      ),
>>>>>>> 4cdc423 (Update project)
    );
    if (result == true) {
      await _loadProducts();
    }
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
          onPressed: () => Navigator.pop(context, true),
        ),
        title: Text(
          'Kelola Produk',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: TextButton.icon(
              onPressed: () => _openForm(),
              icon: Icon(Icons.add, color: Colors.orange),
              label: Text('Tambah', style: TextStyle(color: Colors.orange)),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.orange))
          : products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
<<<<<<< HEAD
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Belum ada produk',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
=======
                      Icon(Icons.inventory_2_outlined,
                          size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Belum ada produk',
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
>>>>>>> 4cdc423 (Update project)
                      SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () => _openForm(),
                        icon: Icon(Icons.add),
                        label: Text('Tambah Produk'),
                        style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                          backgroundColor: Colors.orange,
                        ),
=======
                            backgroundColor: Colors.orange),
>>>>>>> 4cdc423 (Update project)
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
<<<<<<< HEAD
                        borderRadius: BorderRadius.circular(12),
                      ),
=======
                          borderRadius: BorderRadius.circular(12)),
>>>>>>> 4cdc423 (Update project)
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Gambar produk
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                p.image,
                                width: 70,
                                height: 70,
                                fit: BoxFit.contain,
                                errorBuilder: (c, e, s) => Container(
                                  width: 70,
                                  height: 70,
                                  color: Colors.grey[200],
<<<<<<< HEAD
                                  child: Icon(
                                    Icons.phone_android,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
=======
                                  child: Icon(Icons.phone_android,
                                      size: 40, color: Colors.grey),
>>>>>>> 4cdc423 (Update project)
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            // Info produk
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.name,
                                    style: TextStyle(
<<<<<<< HEAD
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
=======
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
>>>>>>> 4cdc423 (Update project)
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    p.price,
                                    style: TextStyle(
<<<<<<< HEAD
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
=======
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
>>>>>>> 4cdc423 (Update project)
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
<<<<<<< HEAD
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 14,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        '${p.rating}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
=======
                                      Icon(Icons.star,
                                          color: Colors.amber, size: 14),
                                      SizedBox(width: 2),
                                      Text('${p.rating}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600])),
                                      SizedBox(width: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
>>>>>>> 4cdc423 (Update project)
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          p.color,
                                          style: TextStyle(
<<<<<<< HEAD
                                            fontSize: 11,
                                            color: Colors.orange,
                                          ),
=======
                                              fontSize: 11,
                                              color: Colors.orange),
>>>>>>> 4cdc423 (Update project)
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Tombol aksi
                            Column(
                              children: [
                                IconButton(
<<<<<<< HEAD
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 22,
                                  ),
=======
                                  icon: Icon(Icons.edit,
                                      color: Colors.blue, size: 22),
>>>>>>> 4cdc423 (Update project)
                                  onPressed: () => _openForm(product: p),
                                  tooltip: 'Edit',
                                ),
                                IconButton(
<<<<<<< HEAD
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 22,
                                  ),
=======
                                  icon: Icon(Icons.delete,
                                      color: Colors.red, size: 22),
>>>>>>> 4cdc423 (Update project)
                                  onPressed: () => _deleteProduct(p),
                                  tooltip: 'Hapus',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        tooltip: 'Tambah Produk',
      ),
    );
  }
}

// ================================================================
// FORM TAMBAH / EDIT PRODUK
// ================================================================
class ProductFormPage extends StatefulWidget {
  final Product? product; // null = tambah baru, ada isi = edit

  ProductFormPage({this.product});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final DatabaseHelper _db = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl;
  late TextEditingController _priceCtrl;
  late TextEditingController _imageCtrl;
  late TextEditingController _reviewsCtrl;

  double _rating = 4.5;
  String _selectedColor = 'Hitam';
  bool _isSaving = false;

  final List<String> _colorOptions = [
<<<<<<< HEAD
    'Hitam',
    'Putih',
    'Silver',
    'Gold',
    'Biru',
    'Merah',
    'Hijau',
    'Purple',
    'Coral',
    'Midnight',
    'Starlight',
=======
    'Hitam', 'Putih', 'Silver', 'Gold', 'Biru', 'Merah',
    'Hijau', 'Purple', 'Coral', 'Midnight', 'Starlight',
>>>>>>> 4cdc423 (Update project)
  ];

  bool get _isEdit => widget.product != null;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _priceCtrl = TextEditingController(
<<<<<<< HEAD
      text: p != null ? p.price.replaceAll(RegExp(r'[^0-9]'), '') : '',
=======
      text: p != null
          ? p.price.replaceAll(RegExp(r'[^0-9]'), '')
          : '',
>>>>>>> 4cdc423 (Update project)
    );
    _imageCtrl = TextEditingController(text: p?.image ?? '');
    _reviewsCtrl = TextEditingController(text: '${p?.reviews ?? 120}');
    _rating = p?.rating ?? 4.5;
    _selectedColor = p?.color ?? 'Hitam';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _imageCtrl.dispose();
    _reviewsCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

<<<<<<< HEAD
    final priceInt =
        int.tryParse(_priceCtrl.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
=======
    final priceInt = int.tryParse(_priceCtrl.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
>>>>>>> 4cdc423 (Update project)
    final priceFormatted = _formatRupiah(priceInt);

    final product = Product(
      id: widget.product?.id,
      name: _nameCtrl.text.trim(),
      price: priceFormatted,
      image: _imageCtrl.text.trim().isEmpty
          ? 'assets/images/12pro.png'
          : _imageCtrl.text.trim(),
      rating: _rating,
      reviews: int.tryParse(_reviewsCtrl.text) ?? 120,
      color: _selectedColor,
    );

    if (_isEdit) {
      await _db.updateProduct(product);
    } else {
      await _db.insertProduct(product);
    }

    setState(() => _isSaving = false);
    Navigator.pop(context, true);

    ScaffoldMessenger.of(context);
  }

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _isEdit ? 'Edit Produk' : 'Tambah Produk',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Preview gambar
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange.withOpacity(0.5)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      _imageCtrl.text.isEmpty
                          ? 'assets/images/12pro.png'
                          : _imageCtrl.text,
                      fit: BoxFit.contain,
<<<<<<< HEAD
                      errorBuilder: (c, e, s) => Icon(
                        Icons.phone_android,
                        size: 60,
                        color: Colors.grey,
                      ),
=======
                      errorBuilder: (c, e, s) => Icon(Icons.phone_android,
                          size: 60, color: Colors.grey),
>>>>>>> 4cdc423 (Update project)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // ---- Nama Produk ----
              _buildLabel('Nama Produk'),
              TextFormField(
                controller: _nameCtrl,
                decoration: _inputDeco('Contoh: iPhone 14 Pro'),
<<<<<<< HEAD
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Nama produk wajib diisi'
                    : null,
=======
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Nama produk wajib diisi' : null,
>>>>>>> 4cdc423 (Update project)
              ),
              SizedBox(height: 16),

              // ---- Harga ----
              _buildLabel('Harga (Rp)'),
              TextFormField(
                controller: _priceCtrl,
                keyboardType: TextInputType.number,
                decoration: _inputDeco('Contoh: 9000000'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Harga wajib diisi';
<<<<<<< HEAD
                  if (int.tryParse(v.replaceAll(RegExp(r'[^0-9]'), '')) ==
                      null) {
=======
                  if (int.tryParse(v.replaceAll(RegExp(r'[^0-9]'), '')) == null) {
>>>>>>> 4cdc423 (Update project)
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // ---- Rating ----
              _buildLabel('Rating: ${_rating.toStringAsFixed(1)}'),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.orange,
                  thumbColor: Colors.orange,
                  overlayColor: Colors.orange.withOpacity(0.2),
                  inactiveTrackColor: Colors.orange.withOpacity(0.3),
                ),
                child: Slider(
                  value: _rating,
                  min: 1.0,
                  max: 5.0,
                  divisions: 40,
                  label: _rating.toStringAsFixed(1),
                  onChanged: (val) => setState(() => _rating = val),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
<<<<<<< HEAD
                  Text(
                    '1.0',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
=======
                  Text('1.0', style: TextStyle(color: Colors.grey, fontSize: 12)),
>>>>>>> 4cdc423 (Update project)
                  Row(
                    children: List.generate(5, (i) {
                      return Icon(
                        i < _rating.floor() ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                  ),
<<<<<<< HEAD
                  Text(
                    '5.0',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
=======
                  Text('5.0', style: TextStyle(color: Colors.grey, fontSize: 12)),
>>>>>>> 4cdc423 (Update project)
                ],
              ),
              SizedBox(height: 16),

              // ---- Jumlah Review ----
              _buildLabel('Jumlah Review'),
              TextFormField(
                controller: _reviewsCtrl,
                keyboardType: TextInputType.number,
                decoration: _inputDeco('Contoh: 120'),
<<<<<<< HEAD
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Jumlah review wajib diisi'
                    : null,
=======
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Jumlah review wajib diisi' : null,
>>>>>>> 4cdc423 (Update project)
              ),
              SizedBox(height: 16),

              // ---- Warna ----
              _buildLabel('Warna Produk'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedColor,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.orange),
                    items: _colorOptions.map((color) {
                      return DropdownMenuItem(
                        value: color,
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: _getColorSwatch(color),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                            ),
                            Text(color),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _selectedColor = val ?? 'Hitam'),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // ---- Path Gambar (opsional) ----
              _buildLabel('Path Gambar (opsional)'),
              TextFormField(
                controller: _imageCtrl,
                decoration: _inputDeco('Contoh: assets/images/iphone14.png'),
                onChanged: (v) => setState(() {}), // update preview
              ),
              SizedBox(height: 8),
              Text(
                'Kosongkan jika gambar belum tersedia',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(height: 32),

              // ---- Tombol Simpan ----
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
<<<<<<< HEAD
                      borderRadius: BorderRadius.circular(12),
                    ),
=======
                        borderRadius: BorderRadius.circular(12)),
>>>>>>> 4cdc423 (Update project)
                  ),
                  child: _isSaving
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
<<<<<<< HEAD
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
=======
                              color: Colors.white, strokeWidth: 2),
>>>>>>> 4cdc423 (Update project)
                        )
                      : Text(
                          _isEdit ? 'Simpan Perubahan' : 'Tambah Produk',
                          style: TextStyle(
<<<<<<< HEAD
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
=======
                              fontSize: 16, fontWeight: FontWeight.bold),
>>>>>>> 4cdc423 (Update project)
                        ),
                ),
              ),
              SizedBox(height: 16),

              // ---- Tombol Batal ----
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
<<<<<<< HEAD
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Batal',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
=======
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Batal',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
>>>>>>> 4cdc423 (Update project)
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }

  InputDecoration _inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.orange),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  Color _getColorSwatch(String colorName) {
    switch (colorName.toLowerCase()) {
<<<<<<< HEAD
      case 'hitam':
        return Colors.black87;
      case 'putih':
        return Colors.grey.shade200;
      case 'silver':
        return Colors.blueGrey.shade300;
      case 'gold':
        return Colors.amber.shade600;
      case 'biru':
        return Colors.blue;
      case 'merah':
        return Colors.red;
      case 'hijau':
        return Colors.green;
      case 'purple':
        return Colors.purple;
      case 'coral':
        return Colors.deepOrange.shade300;
      case 'midnight':
        return Colors.indigo.shade900;
      case 'starlight':
        return Colors.amber.shade100;
      default:
        return Colors.grey;
    }
  }
}
=======
      case 'hitam': return Colors.black87;
      case 'putih': return Colors.grey.shade200;
      case 'silver': return Colors.blueGrey.shade300;
      case 'gold': return Colors.amber.shade600;
      case 'biru': return Colors.blue;
      case 'merah': return Colors.red;
      case 'hijau': return Colors.green;
      case 'purple': return Colors.purple;
      case 'coral': return Colors.deepOrange.shade300;
      case 'midnight': return Colors.indigo.shade900;
      case 'starlight': return Colors.amber.shade100;
      default: return Colors.grey;
    }
  }
}
>>>>>>> 4cdc423 (Update project)

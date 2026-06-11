import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database_helper.dart';
import 'product_model.dart';

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
      MaterialPageRoute(
        builder: (_) => ProductFormPage(product: product),
      ),
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
                      Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Belum ada produk', style: TextStyle(color: Colors.grey, fontSize: 16)),
                      SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () => _openForm(),
                        icon: Icon(Icons.add),
                        label: Text('Tambah Produk'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];
                    
                    Widget imageWidget;
                    if (p.image.startsWith('assets/')) {
                      imageWidget = Image.asset(p.image, width: 70, height: 70, fit: BoxFit.contain);
                    } else {
                      imageWidget = Image.file(File(p.image), width: 70, height: 70, fit: BoxFit.contain);
                    }

                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 70,
                                height: 70,
                                color: Colors.grey[50],
                                child: imageWidget,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.name,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    p.price,
                                    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 14),
                                      SizedBox(width: 2),
                                      Text('${p.rating}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                      SizedBox(width: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          p.color,
                                          style: TextStyle(fontSize: 11, color: Colors.orange),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue, size: 22),
                                  onPressed: () => _openForm(product: p),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red, size: 22),
                                  onPressed: () => _deleteProduct(p),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

// ================================================================
// COMPONENT FORM HALAMAN TAMBAH / EDIT PRODUK
// ================================================================
class ProductFormPage extends StatefulWidget {
  final Product? product;
  ProductFormPage({this.product});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final DatabaseHelper _db = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl;
  late TextEditingController _priceCtrl;
  late TextEditingController _reviewsCtrl;

  String _imagePath = ''; 
  double _rating = 4.5;
  String _selectedColor = 'Hitam';
  bool _isSaving = false;

  final List<String> _colorOptions = [
    'Hitam', 'Putih', 'Silver', 'Gold', 'Biru', 'Merah',
    'Hijau', 'Purple', 'Coral', 'Midnight', 'Starlight',
  ];

  bool get _isEdit => widget.product != null;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _priceCtrl = TextEditingController(
      text: p != null ? p.price.replaceAll(RegExp(r'[^0-9]'), '') : '',
    );
    _reviewsCtrl = TextEditingController(text: '${p?.reviews ?? 120}');
    _rating = p?.rating ?? 4.5;
    _selectedColor = p?.color ?? 'Hitam';
    _imagePath = p?.image ?? '';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _reviewsCtrl.dispose();
    super.dispose();
  }

  // Fungsi interaksi membuka media internal berkas galeri HP
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) return;

    if (_imagePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Peringatan: Berkas foto produk belum di-upload!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    final priceInt = int.tryParse(_priceCtrl.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final priceFormatted = _formatRupiah(priceInt);

    final product = Product(
      id: widget.product?.id,
      name: _nameCtrl.text.trim(),
      price: priceFormatted,
      image: _imagePath, 
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _isEdit ? 'Edit Produk' : 'Tambah Produk',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Gambar Produk'),
              
              // ==========================================================
              // DESIGN BOX COMPONENT: UNTUK UPLOAD & PREVIEW FILE GAMBAR
              // ==========================================================
              GestureDetector(
                onTap: _pickImageFromGallery,
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _imagePath.isEmpty ? Colors.grey.shade300 : Colors.orange.shade300,
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: _imagePath.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate_outlined, size: 42, color: Colors.orange[400]),
                            SizedBox(height: 8),
                            Text(
                              'Tambahkan Gambar',
                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Pilih file foto langsung dari galeri HP Anda',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: Stack(
                            children: [
                              Center(
                                child: _imagePath.startsWith('assets/')
                                    ? Image.asset(_imagePath, fit: BoxFit.contain)
                                    : Image.file(File(_imagePath), fit: BoxFit.contain),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                                  child: Icon(Icons.autorenew, color: Colors.white, size: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),

              // ---- Nama Produk ----
              _buildLabel('Nama Produk'),
              TextFormField(
                controller: _nameCtrl,
                decoration: _inputDeco('Masukkan nama smartphone'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Nama produk wajib diisi' : null,
              ),
              SizedBox(height: 16),

              // ---- Harga ----
              _buildLabel('Harga (Rp)'),
              TextFormField(
                controller: _priceCtrl,
                keyboardType: TextInputType.number,
                decoration: _inputDeco('Contoh: 8500000'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Harga wajib diisi';
                  if (int.tryParse(v.replaceAll(RegExp(r'[^0-9]'), '')) == null) {
                    return 'Masukkan nominal angka saja';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // ---- Rating Slider ----
              _buildLabel('Rating Produk: ${_rating.toStringAsFixed(1)}'),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _rating,
                      min: 1.0,
                      max: 5.0,
                      divisions: 40,
                      activeColor: Colors.orange,
                      inactiveColor: Colors.orange.withOpacity(0.2),
                      onChanged: (val) => setState(() => _rating = val),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.orange[50], borderRadius: BorderRadius.circular(6)),
                    child: Text('${_rating.toStringAsFixed(1)} ★', style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              SizedBox(height: 16),

              // ---- Jumlah Review ----
              _buildLabel('Jumlah Review'),
              TextFormField(
                controller: _reviewsCtrl,
                keyboardType: TextInputType.number,
                decoration: _inputDeco('Masukkan jumlah ulasan awal (Contoh: 150)'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Jumlah ulasan wajib diisi' : null,
              ),
              SizedBox(height: 16),

              // ---- Dropdown Pilihan Warna ----
              _buildLabel('Warna Produk'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedColor,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.orange),
                    items: _colorOptions.map((color) {
                      return DropdownMenuItem(
                        value: color,
                        child: Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: _getColorSwatch(color),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black12),
                              ),
                            ),
                            Text(color, style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedColor = val ?? 'Hitam'),
                  ),
                ),
              ),
              SizedBox(height: 36),

              // ---- Aksi Tombol ----
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: _isSaving
                      ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text(_isEdit ? 'Simpan Perubahan' : 'Tambah Produk Sekarang', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Batal', style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8, top: 4),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
    );
  }

  InputDecoration _inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.orange)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.red)),
    );
  }

  Color _getColorSwatch(String colorName) {
    switch (colorName.toLowerCase()) {
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
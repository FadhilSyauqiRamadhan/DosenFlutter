import 'package:flutter/material.dart';
import '../services/dosen_services.dart';

class TambahDosenPage extends StatefulWidget {
  @override
  _TambahDosenPageState createState() => _TambahDosenPageState();
}

class _TambahDosenPageState extends State<TambahDosenPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nipController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  bool isLoading = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      final success = await DosenService.tambahDosen(
        nipController.text,
        namaController.text,
        teleponController.text,
        emailController.text,
        alamatController.text,
      );
      setState(() => isLoading = false);
      if (success) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambah dosen')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Dosen', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6D4C41))),
        backgroundColor: Color(0xFFF5E6C8),
        iconTheme: IconThemeData(color: Color(0xFF6D4C41)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF8E7), Color(0xFFF5E6C8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 5,
            margin: EdgeInsets.all(24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: nipController,
                      decoration: InputDecoration(
                        labelText: 'NIP',
                        border: OutlineInputBorder(),
                        fillColor: Color(0xFFFFF8E7),
                        filled: true,
                      ),
                      validator: (v) => v!.isEmpty ? 'NIP wajib diisi' : null,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: namaController,
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        border: OutlineInputBorder(),
                        fillColor: Color(0xFFFFF8E7),
                        filled: true,
                      ),
                      validator: (v) => v!.isEmpty ? 'Nama wajib diisi' : null,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: teleponController,
                      decoration: InputDecoration(
                        labelText: 'No Telepon',
                        border: OutlineInputBorder(),
                        fillColor: Color(0xFFFFF8E7),
                        filled: true,
                      ),
                      validator: (v) => v!.isEmpty ? 'No Telepon wajib diisi' : null,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        fillColor: Color(0xFFFFF8E7),
                        filled: true,
                      ),
                      validator: (v) => v!.isEmpty ? 'Email wajib diisi' : null,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: alamatController,
                      decoration: InputDecoration(
                        labelText: 'Alamat',
                        border: OutlineInputBorder(),
                        fillColor: Color(0xFFFFF8E7),
                        filled: true,
                      ),
                      validator: (v) => v!.isEmpty ? 'Alamat wajib diisi' : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD2B48C),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : Text('Simpan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
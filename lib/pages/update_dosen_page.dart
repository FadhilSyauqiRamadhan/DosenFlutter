import 'package:flutter/material.dart';
import '../models/dosen.dart';
import '../services/dosen_services.dart';

class UpdateDosenPage extends StatefulWidget {
  final Dosen dosen;
  UpdateDosenPage({required this.dosen});

  @override
  _UpdateDosenPageState createState() => _UpdateDosenPageState();
}

class _UpdateDosenPageState extends State<UpdateDosenPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nipController;
  late TextEditingController namaController;
  late TextEditingController teleponController;
  late TextEditingController emailController;
  late TextEditingController alamatController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nipController = TextEditingController(text: widget.dosen.nip);
    namaController = TextEditingController(text: widget.dosen.namaLengkap);
    teleponController = TextEditingController(text: widget.dosen.noTelepon);
    emailController = TextEditingController(text: widget.dosen.email);
    alamatController = TextEditingController(text: widget.dosen.alamat);
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      final success = await DosenService.updateDosen(
        widget.dosen.no!,
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
          SnackBar(content: Text('Gagal update dosen')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Dosen', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6D4C41))),
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
                          : Text('Update', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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
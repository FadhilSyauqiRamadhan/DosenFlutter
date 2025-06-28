import 'package:flutter/material.dart';
import '../models/dosen.dart';
import '../services/dosen_services.dart';
import 'update_dosen_page.dart';

class ListDosenPage extends StatefulWidget {
  @override
  _ListDosenPageState createState() => _ListDosenPageState();
}

class _ListDosenPageState extends State<ListDosenPage> {
  late Future<List<Dosen>> _futureDosens;

  @override
  void initState() {
    super.initState();
    _futureDosens = DosenService.fetchDosens();
  }

  void _refresh() {
    setState(() {
      _futureDosens = DosenService.fetchDosens();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Dosen', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6D4C41))),
        backgroundColor: Color(0xFFF5E6C8),
        elevation: 0,
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
        child: FutureBuilder<List<Dosen>>(
          future: _futureDosens,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (!snapshot.hasData || snapshot.data!.isEmpty)
              return Center(child: Text('Tidak ada data', style: TextStyle(fontSize: 18, color: Color(0xFF6D4C41))));
            return ListView(
              padding: EdgeInsets.all(12),
              children: snapshot.data!.map((dosen) => Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFF5E6C8),
                    child: Text(
                      dosen.namaLengkap.isNotEmpty ? dosen.namaLengkap[0] : '?',
                      style: TextStyle(color: Color(0xFF6D4C41), fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(dosen.namaLengkap, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6D4C41))),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NIP: ${dosen.nip}', style: TextStyle(color: Color(0xFF8D6E63))),
                      Text('Telepon: ${dosen.noTelepon}', style: TextStyle(color: Color(0xFF8D6E63))),
                      Text('Email: ${dosen.email}', style: TextStyle(color: Color(0xFF8D6E63))),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Color(0xFFD2B48C)),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => UpdateDosenPage(dosen: dosen)),
                          );
                          if (result == true) _refresh();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Color(0xFFBCAAA4)),
                        onPressed: () async {
                          final confirm = await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Hapus Dosen'),
                              content: Text('Yakin ingin menghapus dosen ini?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Batal')),
                                TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Hapus')),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            final success = await DosenService.deleteDosen(dosen.no!);
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Berhasil dihapus')));
                              _refresh();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal hapus')));
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFD2B48C),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/tambah');
          if (result == true) _refresh();
        },
        child: Icon(Icons.add, size: 28, color: Colors.white),
        tooltip: 'Tambah Dosen',
      ),
    );
  }
}
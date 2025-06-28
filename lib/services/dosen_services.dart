import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/dosen.dart';

class DosenService {
  static const String baseUrl = 'http://10.126.146.139:8000/api/dosen';

  static Future<List<Dosen>> fetchDosens() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Dosen.fromJson(e)).toList();
    }
    throw Exception('Failed to load dosen');
  }

  static Future<bool> tambahDosen(String nip, String nama, String telepon, String email, String alamat) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {
        'nip': nip,
        'nama_lengkap': nama,
        'no_telepon': telepon,
        'email': email,
        'alamat': alamat,
      },
    );
    return response.statusCode == 201;
  }

  static Future<bool> updateDosen(int no, String nip, String nama, String telepon, String email, String alamat) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$no'),
      body: {
        'nip': nip,
        'nama_lengkap': nama,
        'no_telepon': telepon,
        'email': email,
        'alamat': alamat,
      },
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteDosen(int no) async {
    final response = await http.delete(Uri.parse('$baseUrl/$no'));
    return response.statusCode == 200;
  }
}
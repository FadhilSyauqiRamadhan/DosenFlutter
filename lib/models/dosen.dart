class Dosen {
  final int? no;
  final String nip, namaLengkap, noTelepon, email, alamat;

  Dosen({this.no, required this.nip, required this.namaLengkap, required this.noTelepon, required this.email, required this.alamat});

  factory Dosen.fromJson(Map<String, dynamic> json) => Dosen(
    no: json['no'],
    nip: json['nip'],
    namaLengkap: json['nama_lengkap'],
    noTelepon: json['no_telepon'],
    email: json['email'],
    alamat: json['alamat'],
  );
}
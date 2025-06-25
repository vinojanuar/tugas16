import 'package:flutter/material.dart';

class Riwayatpinjaman extends StatefulWidget {
  const Riwayatpinjaman({super.key});

  @override
  State<Riwayatpinjaman> createState() => _RiwayatpinjamanState();
}

class _RiwayatpinjamanState extends State<Riwayatpinjaman> {
  // 🔹 Daftar riwayat pinjaman (contoh data dummy)
  final List<Map<String, dynamic>> riwayatPinjam = [
    {
      'judul': 'Pemrograman Dasar',
      'tanggal': '01 Juni 2025',
      'status': 'Sudah Dikembalikan',
    },
    {
      'judul': 'Algoritma dan Struktur Data',
      'tanggal': '05 Juni 2025',
      'status': 'Masih Dipinjam',
    },
    {
      'judul': 'Basis Data',
      'tanggal': '10 Juni 2025',
      'status': 'Sudah Dikembalikan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pinjaman Buku'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: riwayatPinjam.length,
        itemBuilder: (context, index) {
          final item = riwayatPinjam[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.book),
              title: Text(item['judul']),
              subtitle: Text('Tanggal: ${item['tanggal']}'),
              trailing: Text(
                item['status'],
                style: TextStyle(
                  color: item['status'] == 'Masih Dipinjam'
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

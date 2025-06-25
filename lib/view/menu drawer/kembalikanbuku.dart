import 'package:flutter/material.dart';

class Kembalikanbuku extends StatefulWidget {
  const Kembalikanbuku({super.key});

  @override
  State<Kembalikanbuku> createState() => _KembalikanbukuState();
}

class _KembalikanbukuState extends State<Kembalikanbuku> {
  // 🔹 Daftar buku yang sedang dipinjam
  List<String> bukuDipinjam = [
    'Belajar Flutter',
    'Logika Algoritma',
    'Database Lanjut',
    'Desain UI/UX',
  ];

  // 🔸 Fungsi untuk mengembalikan buku
  void kembalikanBuku(int index) {
    setState(() {
      bukuDipinjam.removeAt(index); // hapus dari daftar pinjaman
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Buku berhasil dikembalikan!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kembalikan Buku'),
        backgroundColor: Colors.green,
      ),
      body: bukuDipinjam.isEmpty
          ? const Center(child: Text('Tidak ada buku yang sedang dipinjam.'))
          : ListView.builder(
              itemCount: bukuDipinjam.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.book, color: Colors.orange),
                    title: Text(bukuDipinjam[index]),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        // konfirmasi sebelum mengembalikan
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: Text(
                              'Kembalikan buku "${bukuDipinjam[index]}"?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  kembalikanBuku(index);
                                  Navigator.pop(context); // tutup dialog
                                },
                                child: const Text('Kembalikan'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Kembalikan'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

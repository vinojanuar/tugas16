import 'package:flutter/material.dart';

class Pinjambuku extends StatefulWidget {
  const Pinjambuku({super.key});

  @override
  State<Pinjambuku> createState() => _PinjambukuState();
}

class _PinjambukuState extends State<Pinjambuku> {
  // 🔹 Daftar buku yang tersedia untuk dipinjam
  List<String> daftarBuku = [
    'Pemrograman Dasar',
    'Jaringan Komputer',
    'Pemrograman Mobile',
    'Sistem Operasi',
    'Struktur Data',
  ];

  // 🔸 Daftar buku yang sudah dipinjam
  List<String> bukuDipinjam = [];

  // 🔸 Fungsi untuk meminjam buku
  void pinjamBuku(int index) {
    setState(() {
      bukuDipinjam.add(daftarBuku[index]); // pindahkan ke daftar pinjaman
      daftarBuku.removeAt(index); // hapus dari daftar tersedia
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Buku berhasil dipinjam!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinjam Buku'),
        backgroundColor: Colors.blueAccent,
      ),
      body: daftarBuku.isEmpty
          ? const Center(child: Text('Tidak ada buku yang tersedia.'))
          : ListView.builder(
              itemCount: daftarBuku.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.book, color: Colors.deepPurple),
                    title: Text(daftarBuku[index]),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Konfirmasi sebelum meminjam
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: Text(
                              'Yakin ingin meminjam "${daftarBuku[index]}"?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  pinjamBuku(index); // proses peminjaman
                                  Navigator.pop(context);
                                },
                                child: const Text('Pinjam'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Pinjam'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

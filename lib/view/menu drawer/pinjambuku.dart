import 'package:flutter/material.dart';
import 'package:tugas16/view/api/user_api.dart'; // Pastikan ini di-import
import 'package:tugas16/view/model/berhasilgetbuku.dart';

class Pinjambuku extends StatefulWidget {
  const Pinjambuku({super.key});

  @override
  State<Pinjambuku> createState() => _PinjambukuState();
}

class _PinjambukuState extends State<Pinjambuku> {
  late Future<List<GetBuku>> _bukuFuture;

  @override
  void initState() {
    super.initState();
    _bukuFuture = UserService().daftarbuku(); // Ambil data dari API
  }

  void pinjamBuku(GetBuku buku) {
    // Proses peminjaman nanti bisa ditambahkan di sini
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Berhasil meminjam: ${buku.title}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pinjam Buku'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<GetBuku>>(
        future: _bukuFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada buku yang tersedia.'));
          }

          final daftarBuku = snapshot.data!;

          return ListView.builder(
            itemCount: daftarBuku.length,
            itemBuilder: (context, index) {
              final buku = daftarBuku[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.book, color: Colors.deepPurple),
                  title: Text(buku.title),
                  subtitle: Text(
                    'Penulis: ${buku.author}\nStok: ${buku.stock}',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: Text(
                            'Yakin ingin meminjam "${buku.title}"?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                pinjamBuku(buku);
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
          );
        },
      ),
    );
  }
}

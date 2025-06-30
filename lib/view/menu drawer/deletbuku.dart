import 'package:flutter/material.dart';
import 'package:tugas16/view/api/user_api.dart';
import 'package:tugas16/view/model/berhasilgetbuku.dart';

class Deletbuku extends StatefulWidget {
  const Deletbuku({super.key});

  @override
  State<Deletbuku> createState() => _DeletbukuState();
}

class _DeletbukuState extends State<Deletbuku> {
  List<GetBuku> daftarBuku = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBuku();
  }

  Future<void> loadBuku() async {
    try {
      final response = await UserService().daftarbuku();
      setState(() {
        daftarBuku = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal memuat buku: $e")));
    }
  }

  void hapusBuku(int index, int id) async {
    try {
      final response = await UserService().deleteBuku(id: id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.message)));
      setState(() {
        daftarBuku.removeAt(index);
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal menghapus buku: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Hapus Buku', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : daftarBuku.isEmpty
          ? const Center(
              child: Text(
                'Tidak ada buku.',
                style: TextStyle(color: Colors.black),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: daftarBuku.length,
              itemBuilder: (context, index) {
                final buku = daftarBuku[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    leading: const Icon(Icons.book, color: Colors.black),
                    title: Text(
                      buku.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      'Penulis: ${buku.author}',
                      style: const TextStyle(color: Colors.black87),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: Text(
                              'Yakin ingin menghapus "${buku.title}"?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  hapusBuku(index, buku.id);
                                },
                                child: const Text(
                                  'Hapus',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

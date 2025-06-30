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

  // void hapusBuku(int index, int id) async {
  //   try {
  //     // final response = await UserService().deleteBuku(id: id);
  //     ScaffoldMessenger.of(
  //       context,
  //     // ).showSnackBar(SnackBar(content: Text(response.message)));
  //     // setState(() {
  //     //   daftarBuku.removeAt(index);
  //     // });
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("Gagal menghapus buku: $e")));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hapus Buku'),
        backgroundColor: Colors.redAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : daftarBuku.isEmpty
          ? const Center(child: Text('Tidak ada buku.'))
          : ListView.builder(
              itemCount: daftarBuku.length,
              itemBuilder: (context, index) {
                final buku = daftarBuku[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.book, color: Colors.blue),
                    title: Text(buku.title),
                    subtitle: Text('Penulis: ${buku.author}'),
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
                              // TextButton(
                              //   onPressed: () {
                              //     Navigator.pop(context);
                              //     hapusBuku(index, buku.id);
                              //   },
                              //   child: const Text(
                              //     'Hapus',
                              //     style: TextStyle(color: Colors.red),
                              //   ),
                              // ),
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

import 'package:flutter/material.dart';
import 'package:tugas16/view/api/user_api.dart';
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
    _bukuFuture = UserService().daftarbuku();
  }

  Future<void> _pinjamBuku(GetBuku buku) async {
    try {
      final service = UserService();
      final result = await service.pinjamBuku(bookId: buku.id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Berhasil meminjam: ${result.data.id}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal meminjam buku: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pinjam Buku"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<GetBuku>>(
        future: _bukuFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada buku tersedia."));
          }

          final bukuList = snapshot.data!;

          return ListView.builder(
            itemCount: bukuList.length,
            itemBuilder: (context, index) {
              final buku = bukuList[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(buku.title),
                  subtitle: Text(
                    "Penulis: ${buku.author}\nStok: ${buku.stock}",
                  ),
                  trailing: ElevatedButton(
                    child: const Text("Pinjam"),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Konfirmasi"),
                        content: Text("Pinjam buku \"${buku.title}\"?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text("Batal"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              _pinjamBuku(buku);
                            },
                            child: const Text("Pinjam"),
                          ),
                        ],
                      ),
                    ),
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

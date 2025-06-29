import 'package:flutter/material.dart';
import 'package:tugas16/view/app_drawer.dart';
import 'package:tugas16/view/api/user_api.dart'; // ⬅️ akses UserService
import 'package:tugas16/view/model/berhasilgetbuku.dart';
import 'package:tugas16/view/model/postbuku.dart'; // ⬅️ akses model buku

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<GetBuku>> _bukuFuture;
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _bukuFuture = UserService().daftarbuku();
    });
  }

  Future<void> _postbuku() async {
    _titleController.clear();
    _authorController.clear();
    _stockController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Tambah Buku Baru"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Judul"),
                ),
                TextField(
                  controller: _authorController,
                  decoration: InputDecoration(labelText: "Penulis"),
                ),
                TextField(
                  controller: _stockController,
                  decoration: InputDecoration(labelText: "Stok"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text.trim();
                final author = _authorController.text.trim();
                final stock = _stockController.text.trim();

                if (title.isEmpty || author.isEmpty || stock.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Semua field harus diisi")),
                  );
                  return;
                }

                try {
                  final buku = await UserService().postbuku(
                    title: title,
                    author: author,
                    stock: stock,
                  );
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Buku berhasil dipost: ${buku.title}"),
                    ),
                  );

                  _loadData();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Gagal post buku: $e")),
                  );
                }
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Perpustakaan",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _postbuku,
            icon: Icon(Icons.add, color: Colors.black),
            tooltip: "Post Buku",
          ),
        ],
      ),
      drawer: const AppDrawer(),

      // 🔽 Tampilan daftar buku
      body: FutureBuilder<List<GetBuku>>(
        future: _bukuFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // loading
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Gagal memuat data: ${snapshot.error}"),
            ); // error
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Tidak ada buku tersedia"),
            ); // kosong
          }

          final daftarBuku = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: daftarBuku.length,
            itemBuilder: (context, index) {
              final buku = daftarBuku[index];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(
                    buku.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text("Penulis: ${buku.author}"),
                      Text("Stok: ${buku.stock}"),
                    ],
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

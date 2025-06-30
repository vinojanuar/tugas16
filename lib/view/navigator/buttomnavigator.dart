import 'package:flutter/material.dart';
import 'package:tugas16/helper/preference.dart';
import 'package:tugas16/view/api/user_api.dart';
import 'package:tugas16/view/login_screen.dart';
import 'package:tugas16/view/model/berhasilgetbuku.dart';
import 'package:tugas16/view/menu drawer/kembalikanbuku.dart';
import 'package:tugas16/view/menu drawer/pinjambuku.dart';
import 'package:tugas16/view/menu drawer/riwayatpinjaman.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 0;
  final GlobalKey<_DaftarBukuState> _homeKey = GlobalKey<_DaftarBukuState>();

  late final List<Widget> _pages = [
    DaftarBuku(key: _homeKey),
    const TambahBukuScreen(),
    const Pinjambuku(),
    const Kembalikanbuku(),
    const RiwayatScreen(),
  ];

  final List<String> _titles = [
    'Beranda',
    'Tambah Buku',
    'Pinjam Buku',
    'Kembalikan Buku',
    'Riwayat Pinjaman',
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.add_box,
    Icons.book_online,
    Icons.assignment_return,
    Icons.history,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        actions: _currentIndex == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.black),
                  onPressed: () => _homeKey.currentState?.loadData(),
                ),
              ]
            : null,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (index) => setState(() => _currentIndex = index),
        items: List.generate(_titles.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(_icons[index]),
            label: _titles[index],
          );
        }),
      ),
    );
  }
}

class DaftarBuku extends StatefulWidget {
  const DaftarBuku({super.key});

  @override
  State<DaftarBuku> createState() => _DaftarBukuState();
}

class _DaftarBukuState extends State<DaftarBuku> {
  late Future<List<GetBuku>> _bukuFuture;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    setState(() {
      _bukuFuture = UserService().daftarbuku();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetBuku>>(
      future: _bukuFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Tidak ada buku tersedia"));
        }

        final daftarBuku = snapshot.data!;
        return RefreshIndicator(
          onRefresh: () async => loadData(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: daftarBuku.length,
            itemBuilder: (context, index) {
              final buku = daftarBuku[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(buku.title),
                  subtitle: Text(
                    "Penulis: ${buku.author} | Stok: ${buku.stock}",
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class TambahBukuScreen extends StatefulWidget {
  const TambahBukuScreen({super.key});

  @override
  State<TambahBukuScreen> createState() => _TambahBukuScreenState();
}

class _TambahBukuScreenState extends State<TambahBukuScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _stockController = TextEditingController();

  void _submit() async {
    final title = _titleController.text.trim();
    final author = _authorController.text.trim();
    final stock = _stockController.text.trim();

    if (title.isEmpty || author.isEmpty || stock.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field harus diisi")));
      return;
    }

    try {
      final buku = await UserService().postbuku(
        title: title,
        author: author,
        stock: stock,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Buku ditambahkan: ${buku.title}")),
      );
      // Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal menambahkan buku: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInput("Judul", _titleController),
            const SizedBox(height: 10),
            _buildInput("Penulis", _authorController),
            const SizedBox(height: 10),
            _buildInput(
              "Stok",
              _stockController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text(
                "Simpan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

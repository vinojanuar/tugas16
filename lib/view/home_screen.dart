// file: home_screen.dart

import 'package:flutter/material.dart';
import 'package:tugas16/view/app_drawer.dart';
import 'package:tugas16/view/api/user_api.dart';
import 'package:tugas16/view/model/berhasilgetbuku.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<GetBuku>>(
        future: _bukuFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Gagal memuat data: ${snapshot.error}"));
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
      ),
    );
  }
}

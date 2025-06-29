import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas16/view/api/user_api.dart';
import 'package:tugas16/view/model/riwayatpinjambuku.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  late Future<Riwayatpinjambuku> riwayat;

  @override
  void initState() {
    super.initState();
    riwayat = UserService().getRiwayatPeminjaman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Peminjaman'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<Riwayatpinjambuku>(
        future: riwayat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Center(child: Text("Belum ada riwayat peminjaman."));
          }

          final riwayatList = snapshot.data!.data;

          return ListView.builder(
            itemCount: riwayatList.length,
            itemBuilder: (context, index) {
              final item = riwayatList[index];
              final buku = item.book;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.book, color: Colors.blue),
                  title: Text(buku.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Penulis: ${buku.author}"),
                      Text(
                        "Tgl Pinjam: ${DateFormat('dd-MM-yyyy').format(item.borrowDate)}",
                      ),
                      Text(
                        item.returnDate == null
                            ? "Belum dikembalikan"
                            : "Tgl Kembali: ${item.returnDate}",
                      ),
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

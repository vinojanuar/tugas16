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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Riwayat Peminjaman',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: FutureBuilder<Riwayatpinjambuku>(
        future: riwayat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada riwayat peminjaman.",
                style: TextStyle(color: Colors.black),
              ),
            );
          }

          final riwayatList = snapshot.data!.data;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: riwayatList.length,
            itemBuilder: (context, index) {
              final item = riwayatList[index];
              final buku = item.book;

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
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        "Penulis: ${buku.author}",
                        style: TextStyle(color: Colors.black87),
                      ),
                      Text(
                        "Tgl Pinjam: ${DateFormat('dd-MM-yyyy').format(item.borrowDate)}",
                        style: TextStyle(color: Colors.black87),
                      ),
                      Text(
                        item.returnDate == null
                            ? "Belum dikembalikan"
                            : "Tgl Kembali: ${item.returnDate}",
                        style: TextStyle(
                          color: item.returnDate == null
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
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

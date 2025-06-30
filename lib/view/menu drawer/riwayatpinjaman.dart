import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas16/helper/preference.dart';
import 'package:tugas16/view/api/user_api.dart';
import 'package:tugas16/view/model/riwayatpinjambuku.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  late Future<List<Riwayat>> _riwayatFuture;

  @override
  void initState() {
    super.initState();
    _riwayatFuture = _fetchUserRiwayat();
  }

  Future<List<Riwayat>> _fetchUserRiwayat() async {
    try {
      final userId = await PreferenceHandler.getUserId();
      if (userId == null) {
        throw Exception("User ID tidak ditemukan. Tidak dapat memuat riwayat.");
      }
      // Panggil method dari UserService untuk mendapatkan riwayat
      return await UserService().getRiwayatPeminjaman();
    } catch (e) {
      print('DEBUG ERROR: Gagal mengambil riwayat pengguna: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Peminjaman'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<Riwayatpinjambuku>(
        future: _riwayatFuture,
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

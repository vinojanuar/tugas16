import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas16/view/api/user_api.dart';
import 'package:tugas16/view/model/riwayatpinjambuku.dart';

class Kembalikanbuku extends StatefulWidget {
  const Kembalikanbuku({super.key});

  @override
  State<Kembalikanbuku> createState() => _KembalikanbukuState();
}

class _KembalikanbukuState extends State<Kembalikanbuku> {
  bool isLoading = true;
  List<Datum> daftarPinjaman = [];

  @override
  void initState() {
    super.initState();
    getDataPeminjaman();
  }

  Future<void> getDataPeminjaman() async {
    try {
      final response = await UserService().getRiwayatPeminjaman();
      setState(() {
        daftarPinjaman = response.data
            .where((item) => item.returnDate == null)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print("Gagal ambil data pinjaman: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _kembalikanBuku(int index) async {
    final returnDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final borrowId = daftarPinjaman[index].id;
    final bookId = daftarPinjaman[index].book.id;

    try {
      await UserService().kembalikanBuku(
        borrowId: borrowId,
        bookId: bookId,
        returnDate: returnDate,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Buku berhasil dikembalikan"),
          backgroundColor: Colors.green,
        ),
      );
      getDataPeminjaman();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal mengembalikan buku: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Kembalikan Buku",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : daftarPinjaman.isEmpty
          ? const Center(
              child: Text(
                'Tidak ada buku yang sedang dipinjam.',
                style: TextStyle(color: Colors.black),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: daftarPinjaman.length,
              itemBuilder: (context, index) {
                final pinjam = daftarPinjaman[index];
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
                      "Judul: ${pinjam.book.title}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      "Tanggal Pinjam: ${DateFormat('yyyy-MM-dd').format(pinjam.borrowDate)}",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text(
                              "Konfirmasi",
                              style: TextStyle(color: Colors.black),
                            ),
                            content: const Text(
                              "Yakin ingin mengembalikan buku ini?",
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "Batal",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _kembalikanBuku(index);
                                },
                                child: const Text(
                                  "Kembalikan",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        "Kembalikan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

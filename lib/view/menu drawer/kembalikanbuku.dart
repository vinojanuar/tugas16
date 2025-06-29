import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:tugas16/view/api/user_api.dart';

import 'package:tugas16/view/model/kembalikanbuku.dart';

class Kembalikanbuku extends StatefulWidget {
  const Kembalikanbuku({super.key});

  @override
  State<Kembalikanbuku> createState() => _KembalikanbukuState();
}

class _KembalikanbukuState extends State<Kembalikanbuku> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _kembalikanBuku(int index) async {
    final returnDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

    try {
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal mengembalikan buku: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kembalikan Buku'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: Text('Tidak ada buku yang sedang dipinjam.'))
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.book, color: Colors.orange),

                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        // konfirmasi sebelum mengembalikan
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Konfirmasi'),

                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // tutup dialog
                                  _kembalikanBuku(index);
                                },
                                child: const Text('Kembalikan'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Kembalikan'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

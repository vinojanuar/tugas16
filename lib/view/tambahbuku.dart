// file: tambah_buku_screen.dart

import 'package:flutter/material.dart';
import 'package:tugas16/view/api/user_api.dart';

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
      Navigator.pop(context); // kembali ke halaman sebelumnya
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal menambahkan buku: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Buku"),
        backgroundColor: Colors.black,
      ),
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

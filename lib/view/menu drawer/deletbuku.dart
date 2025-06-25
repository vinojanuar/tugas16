import 'package:flutter/material.dart';

class Deletbuku extends StatefulWidget {
  const Deletbuku({super.key});

  @override
  State<Deletbuku> createState() => _DeletbukuState();
}

class _DeletbukuState extends State<Deletbuku> {
  // 🔹 Buat daftar buku dummy (sementara)
  List<String> daftarBuku = [
    'Dasar Pemrograman',
    'Flutter untuk Pemula',
    'Algoritma dan Struktur Data',
    'Pemrograman Web',
    'Mobile Development',
  ];

  // 🔸 Fungsi untuk menghapus buku dari daftar
  void hapusBuku(int index) {
    setState(() {
      daftarBuku.removeAt(index); // hapus berdasarkan urutan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hapus Buku'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: daftarBuku.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.book, color: Colors.blue),
              title: Text(daftarBuku[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Munculkan konfirmasi sebelum hapus
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: Text(
                        'Yakin ingin menghapus "${daftarBuku[index]}"?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            hapusBuku(index);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Hapus',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tugas16/view/menu%20drawer/deletbuku.dart';
import 'package:tugas16/view/menu%20drawer/kembalikanbuku.dart';
import 'package:tugas16/view/menu%20drawer/pinjambuku.dart';
import 'package:tugas16/view/menu%20drawer/riwayatpinjaman.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    Icons.account_circle_sharp,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Vino",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 5),

                Text("Email: Vino@gmail.com", style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.bookmark_add, size: 35),
            title: Text(
              "Pinjam Buku",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Pinjambuku()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark_remove, size: 35),
            title: Text(
              "Kembalikan Buku",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Kembalikanbuku()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history, size: 35),
            title: Text(
              "Riwayat Pinjaman",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Riwayatpinjaman(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, size: 35),
            title: Text(
              "Delete Buku",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Deletbuku()),
              );
            },
          ),
        ],
      ),
    );
  }
}

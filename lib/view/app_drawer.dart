// import 'package:flutter/material.dart';
// import 'package:tugas16/helper/preference.dart';
// import 'package:tugas16/view/login_screen.dart';
// import 'package:tugas16/view/menu drawer/deletbuku.dart';
// import 'package:tugas16/view/menu drawer/kembalikanbuku.dart';
// import 'package:tugas16/view/menu drawer/pinjambuku.dart';
// import 'package:tugas16/view/menu drawer/riwayatpinjaman.dart';

// class AppDrawer extends StatefulWidget {
//   const AppDrawer({super.key});

//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> {
//   String userName = 'Nama Pengguna';
//   String userEmail = 'email@pengguna.com';

//   @override
//   void initState() {
//     super.initState();
//     loadUserProfile();
//   }

//   Future<void> loadUserProfile() async {
//     final name = await PreferenceHandler.getUserName() ?? 'Nama Pengguna';
//     final email =
//         await PreferenceHandler.getUserEmail() ?? 'email@pengguna.com';
//     setState(() {
//       userName = name;
//       userEmail = email;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//             decoration: const BoxDecoration(color: Colors.white),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.black,
//               child: const Icon(Icons.person, size: 40, color: Colors.white),
//             ),
//             accountName: Text(
//               userName,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 fontSize: 16,
//               ),
//             ),
//             accountEmail: Text(
//               userEmail,
//               style: const TextStyle(
//                 color: Color.fromARGB(255, 0, 0, 0),
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: [
//                 _drawerItem(
//                   icon: Icons.book_online,
//                   text: "Pinjam Buku",
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const Pinjambuku()),
//                   ),
//                 ),
//                 _drawerItem(
//                   icon: Icons.book_outlined,
//                   text: "Kembalikan Buku",
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const Kembalikanbuku()),
//                   ),
//                 ),
//                 _drawerItem(
//                   icon: Icons.history,
//                   text: "Riwayat Pinjaman",
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const RiwayatScreen()),
//                   ),
//                 ),
//                 _drawerItem(
//                   icon: Icons.delete_forever,
//                   text: "Delete Buku",
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const Deletbuku()),
//                   ),
//                 ),
//                 const Divider(),
//                 _drawerItem(
//                   icon: Icons.logout_outlined,
//                   text: "Logout",
//                   onTap: () async {
//                     await PreferenceHandler.removeToken();
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LoginScreen(),
//                       ),
//                       (route) => false,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _drawerItem({
//     required IconData icon,
//     required String text,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.black),
//       title: Text(
//         text,
//         style: const TextStyle(color: Colors.black, fontSize: 16),
//       ),
//       onTap: onTap,
//     );
//   }
// }

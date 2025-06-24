import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final bool _obscurePassword = true;
  

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil Login"), 
        backgroundColor: Colors.green
        ),
    );

    // Navigator.pushAndRemoveUntil(
    //   context
    //   ,MaterialPageRoute(builder: (context) => )
    //   (route) => false,
    // );
  // } else {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         "Gagal Login, ${res["message"] ?? "Terjadi Kesalahan"}"
  //         )
  //         ,backgroundColor: Colors.red,
  //    ),
  //  );
  // }
 setState(() {
   isLoading = false;
 });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 25),
            children: [
              SizedBox(height: 37),

              Center(child: Image.asset('assets/images/Logo_Perpustakaan.png')),
              Text(
                "Perpustakaan",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),

              //TextFormFieldEmail
              SizedBox(height: 40),
              Text("Email"),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration:  _inputDecoration ("Masukan email anda"),
                validator: (value) =>
                    value!.isEmpty ? 'Email tidak boleh kosong' : null,
              ),

              //TextFormFieldPassword
              SizedBox(height: 20),
              Text("Password"),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration("Masukan password anda").copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: 
                (value) =>
                    value!.isEmpty ? 'Password tidak boleh kosong' : null,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _login, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  elevation: 0
                  minimumSize: Size(double.infinity, 56)
                ),),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      labelStyle: TextStyle(color: Colors.black),
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
}
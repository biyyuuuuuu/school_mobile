import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_mobile/model/model_login.dart';
import 'package:school_mobile/screen_page/home.dart';
import 'package:school_mobile/screen_page/register.dart';
import 'package:school_mobile/utils/cek_sassion.dart';
// 'package:school_mobile/utils/cek_session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  // Key for form
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  // Function to post data
  bool isLoading = false;
  Future<Modellogin?> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(
          Uri.parse('http://127.0.0.1:8080//sistem_akademik/login.php'),
          body: {
            "username": txtUsername.text,
            "password": txtPassword.text,
          });
      Modellogin data = modelloginFromJson(res.body);
      //cek kondisi (ini berdasarkan value respon api
      //value ,1 (ada data login),dan 0 (gagal)
      if (data.value == 1) {
        setState(() {
          //save session
          session.saveSession(
              data.value ?? 0,
              data.id ?? "",
              data.username ?? "",
              data.email ?? ""); // Tambahkan pemanggilan saveSession di sini

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${data.message}")));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageHome()),
              (route) => false);
        });
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${data.message}")));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${data.message}")));
        });
      }
      if (data.email != null) {
        session.saveSession(
          data.value ?? 0,
          data.id ?? "",
          data.username ?? "",
          data.email!,
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC0C0C0),
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'images/logo1.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'SDN 04 PINGGIR', // Teks yang ditambahkan
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 172, 195, 205),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: txtUsername,
                        validator: (val) {
                          return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: txtPassword,
                        obscureText: true,
                        validator: (val) {
                          return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    // Check the form and get input data
                    if (keyForm.currentState?.validate() == true) {
                      // Call login function
                      loginAccount();
                    }
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 45,
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(width: 1, color: Colors.green),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
                (route) => false);
          },
          child: Text(
            'Anda Belum Punya Akun ? Silahkan Register',
            style: TextStyle(
                color: Colors.blue), // Mengubah warna teks menjadi biru
          ),
        ),
      ),
    );
  }
}

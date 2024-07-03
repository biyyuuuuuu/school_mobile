import 'package:flutter/material.dart';
import 'login.dart'; // Import the login page
import 'siswa.dart'; // Import the siswa page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PageHome(),
        '/login': (context) => LoginScreen(), // Add the login route
        '/siswa': (context) => PageSiswa(),
        // Define other routes here
        // '/guru': (context) => PageGuru(),
        // '/kelas': (context) => PageKelas(),
        // '/absen': (context) => PageAbsen(),
        // '/jadwal': (context) => PageJadwal(),
        // '/mapel': (context) => PageMapel(),
      },
    );
  }
}

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  void _onCardTap(BuildContext context, String path) {
    Navigator.pushNamed(context, path);
  }

  void _logout(BuildContext context) {
    // Perform any necessary logout operations here
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Home'),
        actions: [
          GestureDetector(
            onTap: () => _logout(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10), // Add some space at the top
          Expanded(
            child: SizedBox(
              height: 300, // Adjust the height of the cards container
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      // onTap: () => _onCardTap(context, '/siswa'),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PageSiswa()));
                      },
                      child: buildCard('Siswa', 'images/siswa.png', '/siswa'),
                    ),
                    GestureDetector(
                      onTap: () => _onCardTap(context, '/guru'),
                      child: buildCard('Guru', 'images/guru.png', '/guru'),
                    ),
                    GestureDetector(
                      onTap: () => _onCardTap(context, '/kelas'),
                      child: buildCard('Kelas', 'images/kelas.jpg', '/kelas'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20), // Add space between the card rows
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _onCardTap(context, '/absen'),
                    child: buildCard('Absen', 'images/absen.png', '/absen'),
                  ),
                  GestureDetector(
                    onTap: () => _onCardTap(context, '/jadwal'),
                    child: buildCard('Jadwal', 'images/jadwal.jpg', '/jadwal'),
                  ),
                  GestureDetector(
                    onTap: () => _onCardTap(context, '/mapel'),
                    child: buildCard('Mapel', 'images/mapel.png', '/mapel'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String title, String imagePath, String path) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => _onCardTap(context, path), // Handle tap event
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Container(
            width: 150, // Adjust the width of each card
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: 100, // Adjust the image height to fit within the smaller card
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18, // Adjust the font size for smaller card
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

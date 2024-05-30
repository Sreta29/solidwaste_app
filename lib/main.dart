import 'package:flutter/material.dart';
import 'package:solidwaste_app/login_page.dart';
import 'package:solidwaste_app/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => RegisterPage(),
      },
      home: const WelcomePage(),
    );
  }
}

/*class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 5)),
      builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              child: const Text('Move to Welcome Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                );
              },
            ),
          ),
        );
      },
    );
  }
}*/

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo at the top center
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
            ),
            // Text below the logo
            const Text(
              'DBKK Solid Waste Collection',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Buttons for login and sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                    // Navigate to login page
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                    // Navigate to sign up page
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

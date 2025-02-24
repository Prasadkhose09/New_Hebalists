import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'dart:async'; // For Timer
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'firebase_options.dart';

import 'dart:convert'; // For JSON encoding and decoding
import 'package:http/http.dart' as https;



// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final GeminiService _geminiService = GeminiService();
//   String _response = "";
//
//   void _sendMessage() async {
//     if (_controller.text.isNotEmpty) {
//       setState(() {
//         _response = "Loading..."; // Show loading indicator
//       });
//
//       final userMessage = _controller.text;
//       // Call the correct function from GeminiService
//       final chatResponse = await _geminiService.generateContent(userMessage);
//
//       setState(() {
//         _response = chatResponse;
//       });
//
//       _controller.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Your AI Doctor")),
//       body: Stack(
//         children: [
//           // Background Image with Opacity
//           Positioned.fill(
//             child: Opacity(
//               opacity: 0.3, // Adjust opacity as needed
//               child: Image.asset(
//                 'assets/images/ChatscreenBack.jpg', // Replace with your actual image path
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Foreground Content
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _controller,
//                   decoration: const InputDecoration(
//                     labelText: "Ask me anything...",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _sendMessage,
//                   child: const Text("Send"),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   "Response: $_response",
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


class HoverCardExample extends StatefulWidget {
  @override
  _HoverCardExampleState createState() => _HoverCardExampleState();
}

class _HoverCardExampleState extends State<HoverCardExample> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursor Hover Pop-up'),
      ),
      body: Center(
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovered = false;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: _isHovered
                    ? (Matrix4.identity()..scale(1.1))
                    : Matrix4.identity(),


                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: _isHovered
                      ? [BoxShadow(blurRadius: 20, color: Colors.black26)]
                      : [],
                ),
                width: 200,
                height: 150,
                child: Center(
                  child: Text(
                    'Hover me!',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              if (_isHovered)
                Positioned(
                  top: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black26,
                          )
                        ],
                      ),
                      child: Text(
                        'Pop-up Information',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyDzjdbF9SDRmRY0O1olMpp0TmcKYmSp-V8",
        authDomain: "herbalists.firebaseapp.com",
        projectId: "herbalists",
        storageBucket: "herbalists.firebasestorage.app",
        messagingSenderId: "1001074552437",
        appId: "1:1001074552437:web:c86e2b28f3afe4a1f4523c",
        measurementId: "G-BGS1C545X9"));
  }else
  {
    Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Herbal Garden',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Set the splash screen as the initial page
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the login screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Splash2.jpg"), // Splash screen image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// Login Screen with background image and opacity


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with opacity
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Backg.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Login / Sign Up Form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(


                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  Text(
                    isSignUp ? 'Sign Up to Virtual Herbal Garden' : 'Login to Virtual Herbal Garden',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(height: 30),

                  // Email / Phone Field
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email or Phone No",
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Password Field
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),

                  if (isSignUp) ...[
                    SizedBox(height: 20),

                    // Confirm Password Field
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: 20),

                  // Forgot Password
                  if (!isSignUp)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                  SizedBox(height: 20),

                  // Login / Sign Up Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const MyHomePage(title: 'We are Team Herbalists!'),
                        ),
                      );

                      // Handle login/signup logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      isSignUp ? 'Sign Up' : 'Login',
                      style: TextStyle(fontSize: 18,color: Colors.black),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Toggle between Login and Sign Up
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isSignUp = !isSignUp;
                      });
                    },
                    child: Text(
                      isSignUp ? 'Already have an account? Login' : 'New User? Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Main Home Page (Herbs display)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/garden.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Welcome to Virtual Herbal Garden',
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHerbCard(
                        context,
                        title: 'Coriander',
                        imagePath: 'assets/images/images.jpg',
                        onTap: () {
                          print("Clicked on Dhaniya");
                        },
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModelViewerScreenCC(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildHerbCard(
                        context,
                        title: 'Turmeric (Haldi)',
                        imagePath: 'assets/images/download.webp',
                        onTap: () {
                          print("Clicked on Haldi");
                        },
                        onDoubleTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModelViewerScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHerbCard(
                        context,
                        title: 'Aloe Vera',
                        imagePath: 'assets/images/Aloe.jpg',
                        onTap: () {
                          print("Clicked on Aloe Vera");
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildHerbCard(
                        context,
                        title: 'Mint',
                        imagePath: 'assets/images/Mint.jpg',
                        onTap: () {
                          print("Clicked on Mint");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHerbCard(
                        context,
                        title: 'Amla',
                        imagePath: 'assets/images/Amla.jpg',
                        onTap: () {
                          print("Clicked on Amla");
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildHerbCard(
                        context,
                        title: 'Tulsi',
                        imagePath: 'assets/images/Tulsi.jpg',
                        onTap: () {
                          print("Clicked on Tulsi");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHerbCard(
                        context,
                        title: 'Ashwagandha',
                        imagePath: 'assets/images/download.jpg',
                        onTap: () {
                          print("Clicked on Ashwagandha");
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildHerbCard(
                        context,
                        title: 'Neem',
                        imagePath: 'assets/images/Neem.jpg',
                        onTap: () {
                          print("Clicked on Neem");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildHerbCard(
                        context,
                        title: 'Elaichi',
                        imagePath: 'assets/images/Elaichi.jpg',
                        onTap: () {
                          print("Clicked on Elaichi");
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildHerbCard(
                        context,
                        title: 'Bramhani',
                        imagePath: 'assets/images/Bramhani.jpg',
                        onTap: () {
                          print("Clicked on Mint");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.help_outline_rounded),
                label: 'Ai Dr.',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: 0,
            onTap: (int index) {
              switch (index) {
                case 0:
                  // Navigator.push( // Navigate to ChatScreen
                  //   // context,
                  //   // MaterialPageRoute(builder: (context) => ChatScreen()),
                  // );
                  break;
                case 1:
                  print("Cart tapped");
                  break;
                case 2:
                  print("Profile tapped");
                  break;
              }
            },
          ),
        ],
      ),
    );




  }

  Widget _buildHerbCard(
      BuildContext context, {
        required String title,
        required String imagePath,
        VoidCallback? onTap,
        VoidCallback? onDoubleTap,
      }) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Container(
        width: 150,
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


class ModelViewerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("3D View: Haldi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 3D Model Viewer
            Expanded(
              child: Flutter3DViewer(
                src: 'assets/haldi.glb', // Path to the 3D model
              ),
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              "Turmeric (Haldi) is a powerful medicinal herb known for its anti-inflammatory and antioxidant properties. "
                  "It has been used in Ayurveda for centuries for skincare, digestion, and overall health benefits.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Buy Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your purchase link here
                  const url = 'https://chatgpt.com/c/67a18257-a488-800f-b945-144ca126369a';
                  // Open the link
                  // You might need the url_launcher package for this
                },
                child: const Text("Buy Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModelViewerScreenCC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("3D View: Coriander"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 3D Model Viewer
            Expanded(
              child: Flutter3DViewer(
                src: 'assets/coriander.glb', // Path to the 3D model
              ),
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              "Coriander is a fragrant herb that's packed with antioxidants,"
                  " which can help protect your cells from damage. It may also "
                  "have anti-inflammatory properties and could help improve digestion. "
                  "Some studies suggest it may help regulate blood sugar levels and promote heart health."
                  " Additionally, coriander may contribute to healthy skin.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Buy Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your purchase link here
                  const url = 'https://chatgpt.com/c/67a18257-a488-800f-b945-144ca126369a';
                  // Open the link
                  // You might need the url_launcher package for this
                },
                child: const Text("Buy Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



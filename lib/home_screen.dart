import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_screen.dart'; // Import your AuthScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Supabase Auth!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await Supabase.instance.client.auth.signOut();
                  // Navigate to sign-in page and remove all previous routes
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (route) => false, // Remove all previous routes
                  );
                } catch (e) {
                  // Handle error (optional)
                  print('Sign out error: $e');
                }
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

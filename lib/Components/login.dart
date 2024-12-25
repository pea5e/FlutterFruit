import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Components/signup.dart';




class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void>  _Login() async {
    if (_formKey.currentState!.validate()) {
      // Perform sign-up logic here
      final email = _emailController.text;
      final password = _passwordController.text;
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // User is signed in
        User? user = userCredential.user;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User signed in: ${user?.email}')),
          );
          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeApp()),
                  );
            // Timer(Duration(seconds: 3), () => Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => HomeApp()),
            //       ));
          
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')),
          );
        }
      
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _Login,
                child: Text('LogIn'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupApp()),
                  );
                },
                child: Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class SignupApp extends StatelessWidget {

//   const SignupApp(Key? key) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign Up')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Login(ValueKey('my-widget'))),
//             );
//           },
//           child: Text('Login'),
//         ),
//       ),
//     );
//   }
// }
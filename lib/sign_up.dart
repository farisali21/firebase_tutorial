import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/screens/fire_store_page.dart';
import 'package:flutter/material.dart';

import 'constants/decoration.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  String? userUid;
  late final userEmail;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.black54),
                    // suffixIcon: suffixIcon,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  textAlign: TextAlign.start,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  onChanged: (_) {},
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Invalid passowrd';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.name,
                  onChanged: (_) {},
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Invalid value';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'name',
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.name,
                  onChanged: (_) {},
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Invalid value';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'phone',
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: double.infinity,
                  child: FutureBuilder(
                    future: signUp(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(),);
                      } else {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // minimumSize: Size.fromHeight(40),
                            primary: defaultColor,
                            padding: const EdgeInsets.all(12),
                          ),
                          onPressed: () async {
                            final message = await signUp();
                            if (formKey.currentState!.validate()) {
                              if (message != 'Ok') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)));
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FirestorePage(userUid, userEmail),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('SignUp'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<String> signUp() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      CollectionReference users = firestore.collection('users');
      userUid = userCredential.user!.uid;
      userEmail = userCredential.user!.email;
      Map<String, dynamic> data = {
        'name': nameController.text,
        'phone': phoneController.text,
      };
      users.doc(emailController.text).set(data);
      return 'Ok';
    } on FirebaseAuthException catch (e) {
      print(e);
      var errorMessage = 'Authentication failed';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'email-already-in-use') {
        print('email is already exist.');
        errorMessage = 'email is already exist.';
      }
      return errorMessage;
    }
  }
}

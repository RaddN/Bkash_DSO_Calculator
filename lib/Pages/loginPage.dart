import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:validators/validators.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();



  @override
  void dispose() {
    _emailController.clear();
    super.dispose();
  }

  bool isEmailCorrect = true;
  @override
  Widget build(BuildContext context) {
     var width = MediaQuery.of(context).size.width;

    Future logintry(emailAddress,password) async{
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailAddress,
            password: password
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('No user found for that email.'),
          ));
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Wrong password provided for that user.'),
          ));
          print('Wrong password provided for that user.');
        }
      }
    }
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            // color: Colors.red.withOpacity(0.1),
              image: DecorationImage(
                  image: NetworkImage(
                    // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShp2T_UoR8vXNZXfMhtxXPFvmDWmkUbVv3A40TYjcunag0pHFS_NMblOClDVvKLox4Atw&usqp=CAU',
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                  fit: BoxFit.cover,
                  opacity: 0.3)
          ),
          child: Center(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Lottie.network(
                    //   // 'https://assets6.lottiefiles.com/private_files/lf30_ulp9xiqw.json', //shakeing lock
                    //     'https://assets6.lottiefiles.com/packages/lf20_k9wsvzgd.json',
                    //     animate: true,
                    //     height: 120,
                    //     width: 600),
                    // logo here
                    // Image.asset(
                    //   'assets/images/logo_new.png',
                    //   height: 120,
                    //   width: 120,
                    // ),
                    Text(
                      'Log In Now',
                      // style: GoogleFonts.indieFlower(
                      //   textStyle: const TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 40,
                      //   ),
                      // ),
                    ),
                    Text(
                      'Please login to continue using our app',
                      // style: GoogleFonts.indieFlower(
                      //   textStyle: TextStyle(
                      //       color: Colors.black.withOpacity(0.5),
                      //       fontWeight: FontWeight.w300,
                      //       // height: 1.5,
                      //       fontSize: 15),
                      // ),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: isEmailCorrect! ? 280 : 200,
                      // _formKey!.currentState!.validate() ? 200 : 600,
                      // height: isEmailCorrect ? 260 : 182,
                      width: width / 1.1,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20, top: 20),
                            child: TextFormField(
                              controller: _emailController,
                              onChanged: (val) {
                                setState(() {
                                  // isEmailCorrect = isEmail(val);
                                });
                              },
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.purple,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Email",
                                hintText: 'your-email@domain.com',
                                labelStyle: TextStyle(color: Colors.purple),
                                // suffixIcon: IconButton(
                                //     onPressed: () {},
                                //     icon: Icon(Icons.close,
                                //         color: Colors.purple))
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _passController,
                                obscuringCharacter: '*',
                                obscureText: true,
                                decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.purple,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Password",
                                  hintText: '*********',
                                  labelStyle: TextStyle(color: Colors.purple),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty && value!.length < 5) {
                                    return 'Enter a valid password';
                                    {
                                      return null;
                                    }
                                  }
                                },
                              ),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          isEmailCorrect
                              ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0)),
                                  backgroundColor: isEmailCorrect == false
                                      ? Colors.red
                                      : Colors.purple,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 131, vertical: 20)
                                // padding: EdgeInsets.only(
                                //     left: 120, right: 120, top: 20, bottom: 20),
                              ),
                              onPressed: () {
                                  logintry(_emailController.text,_passController.text);

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => loginScreen()));
                              },
                              child: Text(
                                'Log In',
                                style: TextStyle(fontSize: 17),
                              ))
                              : Container(),
                        ],
                      ),
                    ),

                    //this is button
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10.0)),
                    //         backgroundColor: Colors.purple,
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: MediaQuery.of(context).size.width / 3.3,
                    //             vertical: 20)
                    //         // padding: EdgeInsets.only(
                    //         //     left: 120, right: 120, top: 20, bottom: 20),
                    //         ),
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => loginScreen()));
                    //     },
                    //     child: Text(
                    //       'Sounds Good!',
                    //       style: TextStyle(fontSize: 17),
                    //     )), //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You have\'t any account?',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}
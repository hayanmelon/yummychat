import 'package:flutter/material.dart';
import 'package:yummychat/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class LoginSignupScreen extends StatefulWidget {

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance;

  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';


  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save(); // 폼 스테이트 내의 각 텍스트 폼 필드의 onSaved 메소드를 작동시키게 된다.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,

      body : GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // 배경
            Positioned(
              top: 0.0,
                right: 0,
                left: 0,

                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image : DecorationImage(
                      image : AssetImage('image/red.jpg'),
                      fit: BoxFit.fill,
                    )
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top:90, left:20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                              text : 'Welcome',
                              style: TextStyle(letterSpacing: 1.0, fontSize: 25.0, color: Colors.white),
                              children: [
                                TextSpan(
                                  text : !isSignupScreen ? ' Back!' : ' to Yummy Chat!',
                                  style: TextStyle(
                                  letterSpacing: 1.0, fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),)
                              ],
                            )
                        ),
                        Text(!isSignupScreen ? 'Login to continue' : 'Signup to continue',
                          style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 15.0,
                              color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),
            // 텍스트 폼 필드
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: 180,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: EdgeInsets.all(20.0),
                  height: isSignupScreen ? 280 : 250,
                  width: MediaQuery.of(context).size.width-40,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color : Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      )
                    ],
                  ),

                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text('LOGIN',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                                      color: !isSignupScreen ? Pallete.activeColor
                                          : Pallete.textColor1),),
                                  if(!isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text('SIGN UP',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                                        color: isSignupScreen ? Pallete.activeColor
                                            : Pallete.textColor1),),
                                  if(isSignupScreen)
                                    Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        if(isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // username
                                TextFormField(
                                  onChanged: (value){
                                    userName = value!;
                                  },
                                  onSaved : (value){
                                    userName = value!;
                                  },
                                  validator : (value){
                                    if(value!.isEmpty || value.length < 4)
                                      return 'Please enter at least 4 characters';
                                    return null;
                                  },
                                  key : ValueKey(1),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.account_circle,
                                    color: Pallete.iconColor,),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Pallete.textColor1),
                                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Pallete.activeColor),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    hintText: 'User Name',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Pallete.textColor1,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ), // 아이디
                                SizedBox(height: 8,),
                                //useremail
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value){
                                    userEmail = value!;
                                  },
                                  onSaved : (value){
                                    userEmail = value!;
                                  },
                                  validator: (value){
                                    if (value!.isEmpty || !value.contains('@')){
                                      return 'Please enter a valid Email address';
                                    }else
                                      return null;
                                  },
                                  key : ValueKey(2),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email,
                                      color: Pallete.iconColor,),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Pallete.textColor1),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Pallete.activeColor),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    hintText: 'E-mail',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Pallete.textColor1,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ), // 이메일
                                SizedBox(height: 8,),
                                TextFormField(
                                  obscureText: true,
                                  onChanged: (value){
                                    userPassword = value!;
                                  },
                                  onSaved : (value){
                                    userPassword = value!;
                                  },
                                  validator: (value){
                                    if (value!.isEmpty || value.length < 6)
                                      return 'Password must be at least 6 characters long';
                                    return null;
                                  },
                                  key : ValueKey(3),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock,
                                      color: Pallete.iconColor,),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Pallete.textColor1),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Pallete.activeColor),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Pallete.textColor1,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ), // 비밀번호
                              ],
                            ),
                          ),
                        ),
                        if(!isSignupScreen)
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child : Form(
                              key: _formKey,
                              child: Column(
                              children: [
                                TextFormField(
                                  onChanged: (value){
                                    userEmail = value!;
                                  },
                                  onSaved : (value){
                                    userEmail = value!;
                                  },
                                  validator : (value){
                                    if(value!.isEmpty || value.length < 4)
                                      return 'Please enter at least 4 characters';
                                    return null;
                                  },
                                  key : ValueKey(4),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.mail,
                                      color: Pallete.iconColor,),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Pallete.textColor1),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Pallete.activeColor),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    hintText: 'E-mail',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Pallete.textColor1,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                                SizedBox(height: 8,),
                                TextFormField(
                                  obscureText: true,
                                  onChanged: (value){
                                    userPassword = value!;
                                  },
                                  onSaved : (value){
                                    userPassword = value!;
                                  },
                                  validator : (value){
                                    if(value!.isEmpty || value.length < 4)
                                      return 'Please enter at least 4 characters';
                                    return null;
                                  },
                                  key : ValueKey(5),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock,
                                      color: Pallete.iconColor,),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Pallete.textColor1),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Pallete.activeColor),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Pallete.textColor1,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                )
            ),
            // 전송버튼
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: isSignupScreen ? 430 : 390,
              right: 0,
              left: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () async {

                    if (isSignupScreen){
                      _tryValidation();
                      try{
                        final newUser = await _authentication.createUserWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword
                        );
                        if(newUser.user != null){
                          // 성공적으로 등록되었을 경우
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen()));
                        }
                      }catch(e){
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Please Check Your Email and Password'),
                            backgroundColor: Colors.blue,
                          )
                        );
                      }
                    }

                    if(!isSignupScreen){
                      _tryValidation();
                      try{
                        final newUser = await _authentication.signInWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword
                        );
                        if(newUser.user != null){
                          // 성공적으로 등록되었을 경우
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen()));
                        }
                      }catch(e){
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Check Your Email and Password'),
                              backgroundColor: Colors.blue,
                            )
                        );
                      }
                    }

                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 1
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                          colors: [
                            Colors.orange,
                            Colors.red,
                          ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                        )
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ),
            // 구글 로그인 버튼
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: (!isSignupScreen ? MediaQuery.of(context).size.height -250 :  MediaQuery.of(context).size.height -165),
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(isSignupScreen ? 'Or Signup With' : 'Or Sign in With'),
                  SizedBox(height: 10,),
                  TextButton.icon(
                      onPressed: (){},
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: Size(155, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Pallete.googleColor,
                      ),
                      icon: Icon(Icons.add),
                      label: Text('Google')
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

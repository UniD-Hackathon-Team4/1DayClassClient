import 'package:flutter/material.dart';
import '../color.dart';
import '../server.dart';
import 'login.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _pass = new TextEditingController();
  final TextEditingController _contact = new TextEditingController();

  late String _emailAuthCode;

  void validateAndSignUp() {
    if (_formKey.currentState!.validate()) {
      signUp(_email.text, _name.text, _pass.text, _contact.text);
    }
  }


  void signUp(String email, name, pass, contact) async {
    var url = Uri.parse('${serverHttp}/auth/sign-up');

    final data = jsonEncode({'email': email,  'password': pass, 'nickname': name, 'contact': contact});

    var response = await http.post(url, body: data, headers: {
      'Accept': 'application/json',
      "content-type": "application/json"
    });

    print("url: ${url}");
    print(response.statusCode);

    if (response.statusCode == 201) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}');

      var body = jsonDecode(response.body);

      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
        title: const Text(
          '회원가입 성공',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('회원가입에 성공하였습니다.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => LoginPage()),
              // );
            },
            child: const Text('확인'),
          ),
        ],
      ),
      );

      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else{
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            '회원가입 실패',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('회원가입에 실패하였습니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          //FocusManager.instance.primaryFocus?.unfocus();
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          //resizeToAvoidBottomInset : false,
            body: SingleChildScrollView(
                child: new Container(
                  decoration: BoxDecoration(
                  ),
                  child: Container(
                      margin: EdgeInsets.only(
                          top: 120.0, left: 30.0, right: 30.0, bottom: 80.0),
                      child: new Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 40.0),
                              child: Center(
                                child: Text(
                                  '회원가입',
                                  style: new TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(mainColor)),
                                ),
                              ),
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                '이메일',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 15.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff666666), width: 2.0),
                                    ),
                                    contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    hintText: '이메일을 입력하세요.',
                                    hintStyle: TextStyle(fontSize: 16.0)),
                                validator: (value) =>
                                value!.isEmpty ? '이메일을 입력해 주세요.' : null,
                                controller: _email,
                              ),
                              height: 40,
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                '닉네임',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff666666), width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    hintText: '사용할 닉네임을 입력하세요.',
                                    hintStyle: TextStyle(fontSize: 16.0)),
                                validator: (value) =>
                                value!.isEmpty ? '닉네임을 입력해 주세요.' : null,
                                controller: _name,
                              ),
                              height: 40,
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                '전화번호',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 15.0),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff666666), width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    hintText: '전화번호를 입력하세요.',
                                    hintStyle: TextStyle(fontSize: 16.0)),
                                validator: (value) =>
                                value!.isEmpty ? '전화번호를 입력해 주세요.' : null,
                                controller: _contact,
                              ),
                              height: 40,
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                '비밀번호',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 15.0),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff666666), width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    hintText: '비밀번호를 입력하세요.',
                                    hintStyle: TextStyle(fontSize: 16.0)),
                                validator: (value) =>
                                value!.isEmpty ? '비밀번호를 입력해 주세요.' : null,
                                controller: _pass,
                              ),
                              height: 40,
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                '비밀번호 확인',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15.0),
                              child: TextFormField(
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "비밀번호가 확인되지 않았습니다.";
                                  } else if (value != _pass.text) {
                                    return "비밀번호가 일치하지 않습니다.";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff666666), width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    hintText: '비밀번호를 입력하세요.',
                                    hintStyle: TextStyle(fontSize: 16.0)),
                              ),
                              height: 40,
                            ),


                            Container(
                              margin: EdgeInsets.only(top: 60.0, bottom: 10.0),
                              child: new ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(mainColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: new Text(
                                  '회원가입',
                                  style: new TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                                onPressed: () {
                                  validateAndSignUp();
                                },
                              ),
                              height: 45,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('이미 계정이 있으신가요?'),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      );
                                    },
                                    child: Text(
                                      '로그인',
                                      style: TextStyle(
                                        color: Color(mainColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ))));
  }
}
import 'package:firebase/services/login_ser.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<FormState> _loginformkey = GlobalKey();

  String ? username ,password ; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login Page',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: SafeArea(child: _bulidui()),
    );
  }
  Widget _bulidui(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _lognform(),
        ],
      ),
    );
  }

  Widget _title(){
    return const Text(
      'Recip Book',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold
      ),
    );
  }


  Widget _lognform(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width*0.90,
      height: MediaQuery.sizeOf(context).height*0.30,
      child: Form(
        key: _loginformkey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: "emilys",
              onSaved: (value){
                setState(() {
                  username = value;
                });
              },
              validator: (value){
                if(value== null||value.isEmpty){
                  return 'Enter a username';
                }
              },
              decoration: InputDecoration(
                hintText: 'Username'
              ),
              
            ),
            TextFormField(
              initialValue: "emilyspass",
              obscureText: false,
              onSaved: (value){
                setState(() {
                  password = value;
                });
              },
              validator: (value){
                if(value== null||value.length<5){
                  return 'Enter a valid password';
                }
              },
              decoration: InputDecoration(
                hintText: 'Password'
              ),
            ),
              _loginbutton(),
          ],
        ))

    );
  }

  Widget _loginbutton(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width*0.60,
      child: ElevatedButton(
        onPressed: () async {
          if(_loginformkey.currentState?.validate() ?? false){
            _loginformkey.currentState?.save();
            bool result = await AuthService().login(
              username !,
              password !
            );
            if(result){
              Navigator.pushReplacementNamed(context, "/home");

            }else{
              StatusAlert.show(context,duration: const Duration(seconds: 2,),
              
              title: 'Login failed',
              subtitle: 'Please try Again',
              configuration: const IconConfiguration(icon: Icons.error,),
              maxWidth: 260,
              );
            }
            
          }
        },
         child: const Text(
          'Login Button'
          )
          ),
    );

  }

}
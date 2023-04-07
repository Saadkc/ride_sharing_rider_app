import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider/screens/registration_screen.dart';
import 'package:rider/splashScreen/splash_screen.dart';
import '../global/global.dart';
import '../widgets/progress_dialog.dart';


class LoginScreen  extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  {
  final _formKey = GlobalKey<FormState>();


  loginDriverNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialogue(message: "Processing, please Wait",);
        }
    );
    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;


    // for realtime database
    if(firebaseUser!= null)
    {

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "login Successful.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured During login");
    }
  }
  final TextEditingController emailController = new TextEditingController();
  //final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  validationForm()
  {

    if (!emailController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not valid. ");
    }
    else if (passwordController.text.length <6)
    {
      Fluttertoast.showToast(msg: "Password is required. ");
    }
    else
    {
      loginDriverNow();
    }
  }



  @override
  Widget build(BuildContext context) {


//email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //validator: ,
      onSaved: (value)
      {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );



//password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      //validator: ,
      onSaved: (value)
      {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


//Login Button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,

        onPressed: (){
          validationForm();

        },
        child: Text("Login", textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold
          ),
        ),
      ),


    );


    return Scaffold(

        appBar: AppBar(
          title: Text('KIET Ride Sharing App'),
          backgroundColor: Colors.red,
        ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/images/logo1.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Dont have an account? "),
                        GestureDetector(onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        ),
                        ),

                      ],
                    )

                  ],
                ),
              ),
            ),

          ),
        )
      )
    );
  }
}

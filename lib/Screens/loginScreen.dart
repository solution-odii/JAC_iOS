import 'package:flutter/material.dart';
import 'package:jac/Models/httpException.dart';
import 'package:jac/Providers/sigupbackend.dart';
import 'package:jac/Screens/homePage.dart';
import 'package:jac/Screens/registerScreen.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';





class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey =GlobalKey();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _authorizedOrNot = "Not Authorized";
  bool fingerprintStatus = false;
 // bool _hasFingerPrintSupport = false;
 // List<BiometricType> _availableBuimetricType = List<BiometricType>();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog (String message){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Notification'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: (){
              Navigator.of(ctx).pop();
            },
          )
        ],
      )
    );
  }

  var isLoading = false;

  Future<void> _submitLogin() async{
    _loginFormKey.currentState.save();

    setState(() {
     isLoading =true;

    });

    try {
    await Provider.of<SignUpAuth>(context, listen: false).signin(
      _authData['email'],
      _authData['password'],);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed';
        if(error.toString().contains('Bad Credentials')) {
          errorMessage ='Invalid Email/Password';
        }
        _showErrorDialog(errorMessage);

    } catch (error){
      const errorMessage = 'Failed, Please try again';
      _showErrorDialog(errorMessage);
    }

      setState(() {
       isLoading = false; 
       
      });

      
  }


  Future<void> _fingerLogin() async{
    _loginFormKey.currentState.save();

    setState(() {
     isLoading =true;

    });

    try {
    await Provider.of<SignUpAuth>(context, listen: false).signinBio(
      _authData['email'], fingerprintStatus
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed';
        if(error.toString().contains('Invalid Credentials entered')) {
          errorMessage ='Invalid Email/Password';
        }
        _showErrorDialog(errorMessage);

    }  catch (error){
      const errorMessage = 'Failed, Please check your Email or Network Connection and then try again';
      _showErrorDialog(errorMessage);
    } 

      setState(() {
       isLoading = false; 
       
      });

      // setState(() {
      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())); 
      // });
      
  }


    
  // Future<void> _getBiometricsSupport() async {
  //   // 6. this method checks whether your device has biometric support or not
  //   bool hasFingerPrintSupport = false;
  //   try {
  //     hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
  //   } catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _hasFingerPrintSupport = hasFingerPrintSupport;
  //   });
  // }

  // Future<void> _getAvailableSupport() async {
  //   // 7. this method fetches all the available biometric supports of the device
  //   List<BiometricType> availableBuimetricType = List<BiometricType>();
  //   try {
  //     availableBuimetricType =
  //         await _localAuthentication.getAvailableBiometrics();
  //   } catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _availableBuimetricType = availableBuimetricType;
  //   });
  // }


   Future<void> _authenticateMe() async {
    // 8. this method opens a dialog for fingerprint authentication.
    //    we do not need to create a dialog nut it popsup from device natively.
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please make sure you've entered your Email", // message for dialog
        useErrorDialogs: true,// show error in dialog
        stickyAuth: true,// native process
      );
      
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
    });
    if(_authorizedOrNot == 'Authorized'){
      fingerprintStatus = true;
      _fingerLogin();
      
    }
  }

//  @override
//   void initState() {
//     _getBiometricsSupport();
//     _getAvailableSupport();
//     super.initState();
//   }




  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      // validator: (value) {
      //   if (value.isEmpty || !value.contains('@')) {
      //     return 'Invalid Email';
      //   }
      // },
      onSaved: (value) {
        _authData['email'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    final passwordField = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      onSaved: (value) {
        _authData['password'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
         
          labelText: 'Password',
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    return  Scaffold(

          body: Stack(
        children: <Widget>[
          Container(
          
            decoration: BoxDecoration(
                image: DecorationImage(
              image: new AssetImage(
                "assets/images/background1.png",
              ),
              fit: BoxFit.cover,
            ),),),

            Center(
              child: SingleChildScrollView(
        child: Container(
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //   image: new AssetImage(
          //     "assets/images/background1.png",
          //   ),
          //   fit: BoxFit.cover,
          // )),
          //height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Form(
            key: _loginFormKey,
                      child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                ),
                Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(color: Colors.white)),
                  child: emailField,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(color: Colors.white)),
                    child: passwordField),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200.0),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                if(isLoading)
                CircularProgressIndicator(backgroundColor: Colors.pinkAccent, valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
                else
                RaisedButton(
                  onPressed: () {
                    _submitLogin();
                    
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  },
                  child: Text('Sign In', style: TextStyle(color: Colors.white)),
                  color: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(
                    horizontal: 92.0,
                  ),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                
                  RawMaterialButton(
                    onPressed: () {
                      _authenticateMe();
                    },
                    child: Icon(
                      Icons.fingerprint,
                      color: Colors.pinkAccent,
                      size: 35.0,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: const EdgeInsets.all(15.0),
                  ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'New User?',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          ' Register',
                          style: TextStyle(color: Colors.pinkAccent, fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                
                SizedBox(
                  height: 100.0,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    height: 50.0,
                    width: 70.0,
                    image: AssetImage('assets/images/jaclogonow.jpg'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

            )
               ],
      ),
    );
  }
}

// width: 400.0,
// child: Image.asset(
//   'assets/images/incar.jpg',
//   fit: BoxFit.cover,
// ),

// Image(
//   height: 400.0,
//   width: 400.0,
//   image: AssetImage('assets/images/incar.jpg'),
//   fit: BoxFit.cover,
// ),
// Container(

//   decoration: BoxDecoration(
//     image: DecorationImage(
//       image: new AssetImage("assets/images/incar.jpg",),
//       fit: BoxFit.cover,
//     )
//   ),
// ),

import 'package:flutter/material.dart';
import 'package:jac/Components/CarRepairsComponents/CarsRepairsPageOne.dart';
import 'package:jac/Components/CarServicingComponents/CarServicingPageTwo.dart';
import 'package:jac/Constants/MyColors.dart';
import 'package:jac/Models/HttpException.dart';
import 'package:jac/Providers/AuthenticationBackend.dart';
import 'package:jac/Providers/BookingHistoryBackend.dart';
import 'package:location/location.dart';
import 'package:jac/Screens/RegisterScreen.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:jac/Utils/Loader.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jac/Providers/CarServiceCentersBackend.dart';


class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  static var errorMessage;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _authorizedOrNot = "Not Authorized";
  bool fingerprintStatus = false;
  SharedPreferences sharedPreferences;
  String localEmail;
  var isLoading = false;
  int userId;
  String lat;
  String lng;

  var location = new Location();

  local(){

    location.onLocationChanged().listen((LocationData currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      lat=currentLocation.latitude.toString();
      lng = currentLocation.longitude.toString();
      CarRepairFirstPageState.lat = currentLocation.latitude.toString();
      CarRepairFirstPageState.lng = currentLocation.longitude.toString();
      CarServicingPageTwoState.lat = currentLocation.latitude.toString();
      CarServicingPageTwoState.lng = currentLocation.longitude.toString();

    });
  }

  Future<void> getHistory() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getInt('id');

     Provider.of<BookingHistoryBackend> (context, listen: false).fetchBookingHistory(
        userId
    );
  }

  Future<void> submitFetchRequest() async{

    await Provider.of<ServiceCenterBackend>(context, listen: false).fetchCarServiceCenter(
        lat,
        lng,
        'JAC_MOTORS'
    );
  }

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };




  Future<void> _submitLogin() async {
    _loginFormKey.currentState.save();

    setState(() {
      isLoading = true;
    });

    try {
      await Provider.of<AuthenticateBackend>(context, listen: false).signInFetch(
        context,
        _authData['email'],
        _authData['password'],
        fingerprintStatus,
      );
    } on HttpException catch (error) {

    } catch (error) {
      Utils().showErrorDialog(context, errorMessage);
    }

    setState(() {
      isLoading = false;
    });
  }


  Future<void> _fingerLogin() async {
    _loginFormKey.currentState.save();

    setState(() {
      isLoading = true;
    });

    try {
      await Provider.of<AuthenticateBackend>(context, listen: false).signInBioFetch(
        context,
        _authData['email'],
        fingerprintStatus,
      );
    } on Exception catch (error) {
      print(errorMessage);
      Utils().showErrorDialog(context, errorMessage);
    }


    setState(() {
      isLoading = false;
    });
  }


  Future<void> _authenticateMe() async {
    _loginFormKey.currentState.save();
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please make sure you've entered your Email",
        // message for dialog
        useErrorDialogs: true,
        // show error in dialog
        stickyAuth: true, // native process
      );
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
    });
    if (_authorizedOrNot == 'Authorized') {
      fingerprintStatus = true;
      _fingerLogin();
      getHistory();
      submitFetchRequest();

    }
  }





  @override
  void initState() {
    local();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    local();
    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.white,

      style: TextStyle(color: Colors.white, fontSize: 16.0),
      validator: (value) {
        if (value.isEmpty || !value.contains('@')) {
          return 'Invalid Email';
        }
        return null;
      },
      onSaved: (value) {
        _authData['email'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),

          hintText: 'Email',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none
         ),

    );

    final passwordField = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,

      obscureText: true,
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onSaved: (value) {
        _authData['password'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),

          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );


    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage(
                  "assets/images/background1.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                            border: new Border(
                              bottom: new BorderSide(color: Colors.white, style: BorderStyle.solid),
                            ),
                          ),
                          child: emailField,
                        ),
                      ),
                      SizedBox(
                        height: 0.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                            height: 55.0,
                            decoration: BoxDecoration(
                              border: new Border(
                                bottom: new BorderSide(color: Colors.white, style: BorderStyle.solid),
                              ),
                              ),
                            child: passwordField),
                      ),
                      SizedBox(
                        height: 0.0,
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
                      if (isLoading)
                        CircularProgressIndicator(
                          backgroundColor: MyColors.designColor,
                          valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                        )


                      else
                        MaterialButton(
                          height: 50.0,
                          onPressed: () {
                            getHistory();
                            _submitLogin();
                            submitFetchRequest();
                          },
                          child: Text('LOGIN',
                              style: TextStyle(color: Colors.white, fontSize: 16.0)),
                          color: MyColors.designColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 82.0,
                          ),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RawMaterialButton(
                        onPressed: () async {
                          _loginFormKey.currentState.save();
                          sharedPreferences =
                              await SharedPreferences.getInstance();
                          localEmail = sharedPreferences.getString("Email");
                          if (_authData['email'].isEmpty) {
                            Utils().showErrorDialog(context,
                                'Enter Email Address and Proceed to fingerprint authentication');
                          } else if (localEmail != null &&
                              _authData['email'].isNotEmpty) {
                            if (localEmail == _authData['email']) {
                              _authenticateMe();
                            } else if (localEmail != _authData['email']) {
                              Utils().showErrorDialog(context,
                                  'Please Login with Email and Password');
                            }
                          } else if (localEmail == null) {
                            Utils().showErrorDialog(context,
                                'Please Login with Email and Password');
                          }
                        },
                        child: Icon(
                          Icons.fingerprint,
                          color: MyColors.designColor,
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: MyColors.designColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image(
                          height: 50.0,
                          width: 70.0,
                          image: AssetImage('assets/images/image_2.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

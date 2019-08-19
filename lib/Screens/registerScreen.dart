import 'package:flutter/material.dart';
import 'package:jac/Screens/loginScreen.dart';
import 'package:provider/provider.dart';
import '../Providers/sigupbackend.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage(
                  "assets/images/background2.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 120.0),
                      child: Text('REGISTER',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                    ),
                  ],
                ),
                RegisterForm()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  Map<String, String> _authData = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'phoneNumber': '',
    'vehicleModel': '',
    'plateNumber': '',
    'password': '',
  };

  var isLoading = false;
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {}

    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });

    await Provider.of<SignUpAuth>(context, listen: false).signup(
      _authData['firstName'],
      _authData['lastName'],
      _authData['email'],
      _authData['phoneNumber'],
      _authData['vehicleModel'],
      _authData['plateNumber'],
      _authData['password'],
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        //  validator: (value) {
        //             if (value.isEmpty) {
        //               return 'Please Enter Name';
        //             }

        //           },

        onSaved: (value) {
          _authData['firstName'] = value;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          
          labelText: 'First Name',
          
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ));

    final lastName = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      //  validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please Enter Last Name';
      //   }
      // },
      onSaved: (value) {
        _authData['lastName'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          
          labelText: 'Last Name',
          
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

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
        
          border: InputBorder.none),
    );

    final phoneNumber = TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      //  validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please Enter Phone Number';
      //   }
      // },
      onSaved: (value) {
        _authData['phoneNumber'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          
          labelText: 'Phone Number',
        
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    final vehicleModel = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      //  validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Pls Enter Vehicle Model';
      //   }
      // },
      onSaved: (value) {
        _authData['vehicleModel'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          
          labelText: 'Vehicle Model (Optional)',
          
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    final plateNumber = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      onSaved: (value) {
        _authData['plateNumber'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          
          labelText: 'Plate Number (Optional)',
          
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    final password = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      obscureText: true,
      controller: _passwordController,
      //  validator: (value) {
      //   if (value.isEmpty || value.length < 4) {
      //     return 'Password too Short';
      //   }
      // },
      onSaved: (value) {
        _authData['password'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
         
          labelText: 'Password',
          //icon: Icon(Icons.remove_red_eye, color: Colors.black, ),
          
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    final confirmPassword = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.white),
      obscureText: true,
      //  validator: (value) {
      //   if (value != _passwordController) {
      //     return 'Password does not match';
      //   }
      // },

      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          
          labelText: 'Confirm Password',
          
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    return Container(
      //height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white)),
                  child: firstNameField),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white)),
                  child: lastName),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white)),
                  child: emailField),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white)),
                  child: phoneNumber),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white)),
                  child: vehicleModel),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white)),
                  child: plateNumber),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white)),
                  child: password),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 55.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white)),
                  child: confirmPassword),
              SizedBox(
                height: 20.0,
              ),
              if (isLoading)
                CircularProgressIndicator()
              else
                RaisedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: Text('Sign Up', style: TextStyle(color: Colors.white)),
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
              SizedBox(
                height: 0.0,
              ),
              
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already registered?',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        ' Sign In',
                        style: TextStyle(color: Colors.pinkAccent, fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

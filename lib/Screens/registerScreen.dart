import 'package:flutter/material.dart';
import 'package:jac/Constants/mycolors.dart';
import 'package:jac/Screens/loginScreen.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:provider/provider.dart';
import '../Providers/AuthenticationBackend.dart';
import 'package:jac/Constants/constants.dart';
import 'package:jac/Models/carsList.dart';
import 'package:quiver/strings.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
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
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
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
  static var errorMessage;
  String selectedVehicle;
  var isLoading = false;
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  var passKey = GlobalKey<FormFieldState>();


  Map<String, String> _authData = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'phoneNumber': '',
    'vehicleModel': '',
    'plateNumber': '',
    'password': '',
  };


  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
    } else {
      _formKey.currentState.save();
      setState(() {
        isLoading = true;
      });

      try {
        await Provider.of<AuthenticateBackend>(context, listen: false).signUpFetch(
            context,
          _authData['firstName'],
          _authData['lastName'],
          _authData['email'],
          _authData['phoneNumber'],
          _authData['vehicleModel'],
          _authData['plateNumber'],
          _authData['password'],
        );
      } on Exception catch (error) {
        print(errorMessage);
        Utils().showErrorDialog(context, errorMessage);
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Notification'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }


  @override
  Widget build(BuildContext context) {
    CarListTypes vehicle = Constants.carListType;

    final firstNameField = TextFormField(
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please Enter Name';
          }
          return null;
        },
        onSaved: (value) {
          _authData['firstName'] = value;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
          hintText: 'First Name',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ));

    final lastName = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please Enter Last Name';
        }
        return null;
      },
      onSaved: (value) {
        _authData['lastName'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
          hintText: 'Last Name',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
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
//          icon: Padding(
//            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
//            child: Icon(Icons.alternate_email, color: Colors.white),
//          ),
          hintText: 'Email',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    final phoneNumber = TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please Enter Phone Number';
        }
        return null;
      },
      onSaved: (value) {
        _authData['phoneNumber'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
          hintText: 'Phone Number',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );


    final vehicleModel = DropdownButtonFormField<String>(
      value: selectedVehicle,
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter Vehicle Type';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
          hintText: 'Vehicle Type',
          hintStyle: TextStyle(color: Colors.white),
      ),

      items: vehicle.carListTypes.map((carTypes) => DropdownMenuItem<String>(
          value: carTypes.id,
          child: Text(carTypes.description, style: TextStyle(color:  MyColors.designColor),),
        )).toList(),

      onChanged: (String newValue) {
        setState(() {
          selectedVehicle = newValue;
        });
      },
      onSaved: (value) {
        _authData['vehicleModel'] = value.toString();
      },
    );

    final plateNumber = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      onSaved: (value) {
        _authData['plateNumber'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
          hintText: 'Plate Number (Optional)',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    final password = TextFormField(
      key: passKey,
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      controller: _passwordController,
      validator: (value) {
        if (value.isEmpty || value.length < 4) {
          return 'Password too Short';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
    );

    final confirmPassword = TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: true,

      validator: (confirmPassword) {
        if (confirmPassword.isEmpty) return 'Enter confirm password';
        var password = passKey.currentState.value;
        if (!equalsIgnoreCase(confirmPassword, password))
          return 'Confirm Password invalid';

        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 15.0),
          hintText: 'Confirm Password',
          hintStyle: TextStyle(color: Colors.white),
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
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(color: Colors.white, style: BorderStyle.solid),
                      ),
                    ),
                    child: firstNameField),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(color: Colors.white, style: BorderStyle.solid),
                      ),
                    ),
                    child: lastName),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(color: Colors.white, style: BorderStyle.solid),
                      ),
                    ),
                    child: emailField),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(color: Colors.white, style: BorderStyle.solid),
                      ),
                    ),
                    child: phoneNumber),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(color: Colors.white, style: BorderStyle.solid),
                      ),
                    ),
                    child: vehicleModel),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(color: Colors.white, style: BorderStyle.solid),
                      ),
                    ),
                    child: plateNumber),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(color: Colors.white, style: BorderStyle.solid),
                      ),
                    ),
                    child: password),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(color: Colors.white, style: BorderStyle.solid),
                      ),
                    ),
                    child: confirmPassword),
              ),
              SizedBox(
                height: 20.0,
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
                    _submit();
                  },
                  child: Text('SIGN UP', style: TextStyle(color: Colors.white, fontSize: 16.0)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already registered?',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      ' Sign In',
                      style: TextStyle(
                          color: MyColors.designColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
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

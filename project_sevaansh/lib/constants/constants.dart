import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircularProgressIndicator(
            color: Color(0xffe16555),
          ),
          const SizedBox(
            height: 18.0,
          ),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading..."),
          ),
        ]),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "account already used.Go to login page";
    case "ERROR_WRONG_PASSWORD":
      return "entered wrong password";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email";
    case "ERROR_USER_DISABLED":
      return "User disabled";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many request to log in this acocunt";
    case "ERROR_OPERATTION_NOT_ALLOWEd":
      return "This operation is not allowed";
    case "ERROR_INVALID_EMAIL":
      return "Entered Email is invalid";
    default:
      return "Login Failed. Please try again!";
  }
}

bool loginValidation(String email, password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("E-mail & Password is empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("E-mail is empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is empty");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("All fields are empty");
    return false;
  } else if (name.isEmpty) {
    showMessage("name is empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is empty");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone is empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is empty");
    return false;
  } else {
    return true;
  }
}

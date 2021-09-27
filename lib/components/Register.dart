import 'package:flutter/material.dart';
import 'package:my_school_app/helpers/colors.dart';



class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13),
      child: Form(
        child: Column(
          children: [
            Spacer(),
            TextFormField(

              decoration: InputDecoration(
                fillColor: button,
                hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(color: bg))
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  fillColor: button,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: bg))
                ),
              ),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                fillColor: button,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(color: bg))
              ),
            ),
            Spacer(flex: 2)
          ],
        ),
      ),
    );
  }
}
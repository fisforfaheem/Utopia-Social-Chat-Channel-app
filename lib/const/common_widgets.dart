import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';

getCustomeTextField(hint, error, controller) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: TextFormField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
      keyboardType: TextInputType.name,
      validator: (val) {
        if (val!.isEmpty) {
          return error;
        }

        return null;
      },
    ),
  );
}

getSearchtextField(hint, error, controller, Function onChanged) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: TextFormField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
      keyboardType: TextInputType.name,
      onChanged: (txt) async {
        var d = await getSearch(txt);
        onChanged(d);
      },
      validator: (val) {
        if (val!.isEmpty) {
          return error;
        }

        return null;
      },
    ),
  );
}

getCustomeTextFieldwithController(hint, error, controller) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: TextFormField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
      //  keyboardType: TextInputType.name,
      validator: (val) {
        if (val!.isEmpty) {
          return error;
        }

        return null;
      },
    ),
  );
}

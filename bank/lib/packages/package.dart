import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


 Widget  formfield({
     required FormFieldSetter<String> save,
     required FormFieldValidator<String> valid,
     required Icon prfixicon,
   required Key key,
     required TextInputType typeKeyboard,
      suffixicon, show,} ){
  return TextFormField(
    key: key,

    obscureText:show,
    validator:valid,
    onSaved: save,
    style: const TextStyle(
        fontSize: 25.0
    ),
    decoration:   InputDecoration(
      prefixIcon: prfixicon,
      suffixIcon: suffixicon !=null ? suffixicon :null ,
      filled: true,
      fillColor: Colors.white,
      enabledBorder: const OutlineInputBorder(
        borderSide:  BorderSide(width: 3, color: Colors.grey),
      ),
    ),
    keyboardType: typeKeyboard,



  );
}


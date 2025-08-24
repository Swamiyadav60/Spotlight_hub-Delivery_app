import 'package:flutter/material.dart';

class Uihelper {
  static void customAlertBox(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  static  customTextField(
    TextEditingController controller,
    String text,
    IconData icondata,
    bool toHide,
  ) {
    return TextField(
      controller: controller, 
      obscureText: toHide,
      decoration: InputDecoration(
                  hintText: 'text',
                  suffixIcon: Icon(icondata),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
    );
  }
  static customButtom(VoidCallbackAction voidCallback,String text){
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(onPressed: (){}, child: Text(text,style: TextStyle(color: Colors.white,fontSize: 20),),
    ),);

  }
}

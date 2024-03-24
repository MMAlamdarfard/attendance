import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFields extends StatefulWidget {
  const CustomTextFields({
    super.key,
    required this.textEditingController,
    this.lableText,
    this.hint,
    this.prefixIcon,
    this.isPassword=false,
    this.greyColor, 
    this.textError,
    this.textHelper,
    this.onFieldSubmitted,
    this.textInputAction,
    this.myFocusNode, 
    this.autofocus=false,
    this.formatter,
    this.onChange, 
    this.iconColor,
    this.havePadding=true,
    this.type,
    this.maxLength,
    this.textAlign
    });
  final TextAlign? textAlign;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController textEditingController;
  final String? lableText;
  final String? hint;
  final Color? greyColor;
  final Color? iconColor;
  final String? textError;
  final String? textHelper;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction; 
  final FocusNode? myFocusNode;
  final bool autofocus;
  final List<TextInputFormatter>? formatter;
  final void Function(String)? onChange;
  final bool havePadding;
  final TextInputType? type;
  final int? maxLength;
  @override
  State<CustomTextFields> createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<CustomTextFields> {
  
  bool passVisibility=true;
  
  

 

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: widget.havePadding? 20:0,),
      child: TextFormField(
          keyboardType: widget.type,
         onChanged: widget.onChange,
         textInputAction: widget.textInputAction,          
        focusNode: widget.myFocusNode,
        obscureText: widget.isPassword? passVisibility:false,
        onFieldSubmitted:widget.onFieldSubmitted,
        autofocus: widget.autofocus,
         
        decoration: InputDecoration(
          contentPadding: widget.havePadding? const EdgeInsets.all(10):null,
          hintText: widget.hint,
          
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.greyColor??Colors.grey, width:1.5),
                borderRadius : const BorderRadius.all(Radius.circular(5.0)),
          ),
          
          errorText: widget.textError,
          helperText: widget.textHelper??"",
          labelText: widget.lableText,
          prefixIcon: Icon(
              widget.prefixIcon,
              color: widget.iconColor,
          ),
          
          suffixIcon: widget.isPassword?   IconButton(icon: !passVisibility
            ? Icon(
              Icons.visibility_off,
              color: widget.iconColor,
              )
            : Icon(
              Icons.visibility,
              color: widget.iconColor,
            ),
            onPressed: (){
              setState(() {
                 passVisibility=!passVisibility;
              });
             
            },
            ):null,
          labelStyle:  TextStyle(
          //  fontSize: 14,
            height: 1,
            color: widget.greyColor
            //color: myFocusNode.hasFocus ? Colors.purple : Colors.black
          ),
          border: const OutlineInputBorder(
            
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder:  const OutlineInputBorder(
             borderSide: BorderSide(color: Color(0xFF1F54D3),width: 1.5)
          ),
          
          floatingLabelStyle:  TextStyle(
            color: ((widget.textError??"").isNotEmpty)? Colors.red.shade900:const Color(0xFF1F54D3),
            fontSize: 16,
            fontWeight: FontWeight.bold
          )
        ),
        //validator: (value) => value!.isEmpty ? 'Please, fill this field.' : null,
        controller: widget.textEditingController,
      ),
    );
  }
}
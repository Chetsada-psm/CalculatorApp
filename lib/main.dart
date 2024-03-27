import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String Result = "0";
  String expression = "";

  buttonPressed(String value){
    print(value);
    
    setState(() {
      if (value == "CLEAR"){
        Result = "0";
      }else if(value == "."){
        if(Result.contains(".")){
          return;
        }else{
          Result = Result + value;
        }
      }else if(value == "="){
        expression = Result.replaceAll("x", "*");

        Parser p = Parser();
        Expression exp = p.parse(expression);
        
        ContextModel cm = ContextModel();
        dynamic calculate = exp.evaluate(EvaluationType.REAL, cm);

        Result = "$calculate";

      }else{

        if(Result == "0"){
          Result = value;
      }else{
        Result = Result + value;
      }
        }
        
    });
    
  }

  myButton(String buttonLabel){
    return Expanded(child: OutlinedButton(
      onPressed:() => buttonPressed(buttonLabel), 
      child: Text(
      buttonLabel,
    style:const TextStyle(fontSize: 20),
      )));
  }

  


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Calculator"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                alignment: Alignment.centerRight,
                child: Text(
                  Result,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
        
              Expanded(child: Divider()),
        
              Column(
                children: [
                  Row(
                children: [
                  myButton("7"),
                  myButton("8"),
                  myButton("9"),
                  myButton("/"),
                ],
              ),
              Row(
                children: [
                  myButton("4"),
                  myButton("5"),
                  myButton("6"),
                  myButton("x"),
                ],
              ),
              Row(
                children: [
                  myButton("1"),
                  myButton("2"),
                  myButton("3"),
                  myButton("-"),
                ],
              ),
              Row(
                children: [
                  myButton("."),
                  myButton("0"),
                  myButton("00"),
                  myButton("+"),
                ],
              ),
              Row(
                children: [
                  myButton("CLEAR"),
                  myButton("="),
                ],
              )
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
}

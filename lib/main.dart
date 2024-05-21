import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: false,
        hintColor: Colors.indigoAccent,
        scaffoldBackgroundColor: Colors.grey.shade200,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black87),
          bodyText2: TextStyle(color: Colors.black87),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final wtController = TextEditingController();
  final ftController = TextEditingController();
  final inController = TextEditingController();
  String result = "";
  Color bgColour = Colors.indigo.shade200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'BMI Calculator',
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.shade400,
                  Colors.indigo.shade800,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BMI',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              buildTextField('Enter your weight in KG', Icons.line_weight, wtController),
              SizedBox(height: 11),
              buildTextField('Enter your height in feet', Icons.height, ftController),
              SizedBox(height: 11),
              buildTextField('Enter your height in inches', Icons.height, inController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateBMI,
                child: Text('Calculate'),
              ),
              SizedBox(height: 20),
              Text(
                result,
                style: TextStyle(fontSize: 19),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }

  void calculateBMI() {
    var wt = wtController.text.toString();
    var ft = ftController.text.toString();
    var inch = inController.text.toString();

    if (wt.isNotEmpty && ft.isNotEmpty && inch.isNotEmpty) {
      var iWt = int.parse(wt);
      var iFt = int.parse(ft);
      var iInch = int.parse(inch);

      var tInch = (iFt * 12) + iInch;
      var tCm = tInch * 2.54;
      var tM = tCm / 100;

      var bmi = iWt / (tM * tM);

      var msg = "";
      if (bmi > 25) {
        msg = "You're Overweight!!";
        bgColour = Colors.red.shade200;
      } else if (bmi < 18.5) {
        msg = "You're Underweight!!";
        bgColour = Colors.orange.shade200;
      } else {
        msg = "You're Healthy!!";
        bgColour = Colors.green.shade200;
      }

      setState(() {
        result = "$msg\nYour BMI is: ${bmi.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        result = 'Please fill all required fields';
      });
    }
  }
}







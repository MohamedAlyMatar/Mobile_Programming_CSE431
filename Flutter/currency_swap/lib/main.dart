import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Exchange App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExchangeApp(),
    );
  }
}

class ExchangeApp extends StatefulWidget {
  const ExchangeApp({super.key});

  @override
  State<ExchangeApp> createState() => _ExchangeAppState();
}

class _ExchangeAppState extends State<ExchangeApp> {
  ///// Global Variables and functions /////////////////////////////////////////
  List<String> CurrencyA = ["EGP", "USD", "EUR"];
  List<String> CurrencyB = ["EGP", "USD", "EUR"];
  late String myValue1 = CurrencyA[0];
  late String myValue2 = CurrencyB.first;
  String? enteredValue;
  double result = 0.0;

  double calculate() {
    double enteredAmount = double.parse(enteredValue!);
    double convertedAmount;

    // Define your conversion rates here
    double eurToUsdRate = 1.06;
    double eurToEgpRate = 32.73;
    double usdToEurRate = 0.94;
    double usdToEgpRate = 40.86;
    double egpToUsdRate = 0.032;
    double egpToEurRate = 0.031;

    if (myValue1 == 'EUR' && myValue2 == 'USD') {
      convertedAmount = enteredAmount * eurToUsdRate;
    } else if (myValue1 == 'EUR' && myValue2 == 'EGP') {
      convertedAmount = enteredAmount * eurToEgpRate;
    } else if (myValue1 == 'USD' && myValue2 == 'EUR') {
      convertedAmount = enteredAmount / usdToEurRate;
    } else if (myValue1 == 'USD' && myValue2 == 'EGP') {
      convertedAmount = enteredAmount * usdToEgpRate;
    } else if (myValue1 == 'EGP' && myValue2 == 'USD') {
      convertedAmount = enteredAmount * egpToUsdRate;
    } else if (myValue1 == 'EGP' && myValue2 == 'EUR') {
      convertedAmount = enteredAmount * egpToEurRate;
    } else {
      convertedAmount = enteredAmount * 1.0; // Default to no conversion
    }
    return convertedAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Change Your Currency Today!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                  items: CurrencyA.map((String Value) {
                    return DropdownMenuItem(
                      value: Value,
                      child: Text(Value),
                    );
                  }).toList(),
                  value: myValue1,
                  onChanged: (String? Value) {
                    setState(() {
                      myValue1 = Value!;
                    });
                  }),
              SizedBox(
                width: 200,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Enter the value...",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (Val) {
                    setState(() {
                      enteredValue = Val;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                      items: CurrencyB.map((String Value) {
                        return DropdownMenuItem(
                          value: Value,
                          child: Text(Value),
                        );
                      }).toList(),
                      value: myValue2,
                      onChanged: (String? Value) {
                        setState(() {
                          myValue2 = Value!;
                        });
                      }),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          result = calculate();
                        });
                      },
                      icon: Icon(Icons.calculate_rounded))
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 2,
                  ),
                ),
                width: 200,
                height: 60,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(15),
                child: Text("$result"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

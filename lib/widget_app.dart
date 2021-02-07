import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController gasolineController = TextEditingController();
  TextEditingController ethanolController = TextEditingController();

  String _infoText = "Informe o valor de cada combustível";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gasolina ou álcool?"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
          onPressed: () {
            _resetValues();
          },)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
                      Icon(Icons.directions_car, size: 60.0, color: Colors.orange),
                      buildTextFormFieldGasoline(),
                      buildTextFormFieldEthanol(),
                      buildContainerButton(context),
                      buidTextInfo(),
                                        ],
                                      ),
                            ),
      )
    );
  }
          
  buildTextFormFieldGasoline() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Preço da gasolina",
        labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)
      ),
      style: TextStyle(fontSize: 30.0),
      controller: gasolineController,
      validator: (value) {
        if (value.isEmpty) {
          return "Informe o valor da gasolina";
        }
        
        return null;
      },
    );
  }

  buildTextFormFieldEthanol() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Preço do etanol",
        labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)
      ),
      style: TextStyle(fontSize: 30.0),
      controller: ethanolController,
      validator: (value) {
        if (value.isEmpty) {
          return "Informe o valor do etanol";
        }
        
        return null;
      },
    );
  }

  buildContainerButton(BuildContext context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculate();
            FocusScope.of(context).requestFocus(new FocusNode());
          }
        },
        child: Text("Calcular",
        style: TextStyle(color: Colors.white, fontSize: 20.0),),
        color: Colors.orange,
      ),
    );
  }

  buidTextInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Text(_infoText,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0),
          ),
    );
  }

  void calculate(){
    setState(() {
      double gasoline = double.parse(gasolineController.text);
      double ethanol = double.parse(ethanolController.text);

      double result = ethanol/gasoline;

      if (result > 0.70) {
        _infoText = "Percentual: ${result.toStringAsPrecision(3)}\nVale a pena abastecer com gasolina";
      }
      else {
        _infoText = "Percentual: ${result.toStringAsPrecision(3)}\nVale a pena abastecer com álcool";
      }
    });
  }

  _resetValues() {
    setState(() {
      gasolineController.text = "";
      ethanolController.text = "";
      _infoText = "Informe o valor de cada combustível";
    });
  }
}
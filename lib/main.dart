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
      title: 'Calculadora de GAP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculadora de GAP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum SelectTapaPiston { none, tapa, piston }

enum SelectSistema { none, SI, STI }

class _MyHomePageState extends State<MyHomePage> {
  //ESTILOS
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  final ButtonStyle styleClean = ElevatedButton.styleFrom(
      primary: Colors.amberAccent, textStyle: const TextStyle(fontSize: 20));

  SelectSistema? sistema = SelectSistema.none;
  SelectTapaPiston? selectTapaPiston = SelectTapaPiston.none;

  double GAPmax = 0;
  double GAPmin = 0;

// TAPA
  double d1min = 0; // Vastago
  double D2max = 0; //  Wear Ring máximo (D2max)
  double D3max = 0; // máximo de la Tapa
  double D3min = 0; // minimo de la Tapa

//PISTON
  double D1max = 0; //  diámetro  máximo de la Camisa
  double d2min = 0; // mínimo de Wear Ring
  double d3max = 0; // máximo del Pistón
  double d3min = 0; // mínimo del Pistón
  double Smax = 0; // máxima de Wear Ring
  double di = 0; // coeficiente de dilatacion

  double Smin = 0; // mínima de Wear Ring

  //CONTROLADORES
  late TextEditingController _d1min;
  late TextEditingController _D2max;
  late TextEditingController _D3max;
  late TextEditingController _D3min;

  late TextEditingController _D1max;
  late TextEditingController _d2min;
  late TextEditingController _d3max;
  late TextEditingController _d3min;
  late TextEditingController _Smax;
  late TextEditingController _di;

  late TextEditingController _Smin;

  @override
  void initState() {
    //MANEJO DE ESTADO :  AL INICIO
    super.initState();
    _d1min = TextEditingController();
    _D2max = TextEditingController();
    _D3max = TextEditingController();
    _D3min = TextEditingController();
    _D1max = TextEditingController();
    _d2min = TextEditingController();
    _d3max = TextEditingController();
    _d3min = TextEditingController();
    _Smax = TextEditingController();
    _di = TextEditingController();
    _Smin = TextEditingController();
  }

  @override
  void dispose() {
    //MANEJO DE ESTADO :  AL FINAL
    _d1min.dispose();
    _D2max.dispose();
    _D3max.dispose();
    _D3min.dispose();
    _D1max.dispose();
    _d2min.dispose();
    _d3max.dispose();
    _d3min.dispose();
    _Smax.dispose();
    _di.dispose();
    _Smin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  width: 400,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                            '¿Desea calcular el GAP de la Tapa o Piston?'),
                        ListTile(
                            title: const Text('Tapa'),
                            leading: Radio<SelectTapaPiston>(
                                value: SelectTapaPiston.tapa,
                                groupValue: selectTapaPiston,
                                onChanged: (SelectTapaPiston? value) {
                                  setState(() {
                                    selectTapaPiston = value;
                                  });
                                })),
                        ListTile(
                            title: const Text('Piston'),
                            leading: Radio<SelectTapaPiston>(
                                value: SelectTapaPiston.piston,
                                groupValue: selectTapaPiston,
                                onChanged: (SelectTapaPiston? value) {
                                  setState(() {
                                    selectTapaPiston = value;
                                  });
                                }))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                            '¿Sistema Internacional (SI) o Sistema Técnico Inglés (STI)?'),
                        ListTile(
                            title: const Text('Sistema Internacional (SI)'),
                            leading: Radio<SelectSistema>(
                                value: SelectSistema.SI,
                                groupValue: sistema,
                                onChanged: (SelectSistema? value) {
                                  setState(() {
                                    sistema = value;
                                  });
                                })),
                        ListTile(
                            title: const Text('Sistema Técnico Inglés (STI)'),
                            leading: Radio<SelectSistema>(
                                value: SelectSistema.STI,
                                groupValue: sistema,
                                onChanged: (SelectSistema? value) {
                                  setState(() {
                                    sistema = value;
                                  });
                                }))
                      ],
                    ),
                  ),
                ),
                selectTapaPiston == SelectTapaPiston.tapa
                    ? Container(
                        width: 400,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 8),
                              TextField(
                                controller: _d1min,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:
                                        'Ingrese el diámetro mínimo del Vastago'),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _D2max,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:
                                        'Ingrese alojamiento de Wear Ring máximo'),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _D3max,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:
                                        'Ingrese el diámetro interno máximo de la Tapa'),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _D3min,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:
                                        'Ingrese el diámetro interno mínimo de la Tapa'),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _Smin,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:
                                        'Ingrese la sección mínima de Wear Ring'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : selectTapaPiston == SelectTapaPiston.piston
                        ? Container(
                            width: 400,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _D1max,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Ingrese el diámetro  máximo de la Camisa'),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _d2min,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Ingrese alojamiento mínimo de Wear Ring'),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _d3max,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Ingrese el diámetro externo máximo del Pistón'),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _d3min,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Ingrese el diámetro externo mínimo del Pistón'),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _Smax,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Ingrese la sección máxima de Wear Ring'),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _Smin,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Ingrese la sección minimo de Wear Ring'),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _di,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Ingrese el coeficiente de dilatacion'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(height: 10),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: style,
                      onPressed: selectTapaPiston == SelectTapaPiston.none ||
                              sistema == SelectSistema.none
                          ? null
                          : () {
                              if (!datosValidos()) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Datos Erroneos'),
                                      content: const Text(
                                          'Todos los valores son obligatorios y deben ser positivos'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Entendido'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                calcularGAP(context);
                              }
                            },
                      child: const Text('Calcular'),
                    ),
                    ElevatedButton(
                      style: styleClean,
                      onPressed: () {
                        _d1min.clear();
                        _D2max.clear();
                        _D3max.clear();
                        _D3min.clear();
                        _D1max.clear();
                        _d2min.clear();
                        _d3max.clear();
                        _d3min.clear();
                        _Smax.clear();
                        _di.clear();
                        _Smin.clear();
                      },
                      child: const Text('Limpiar'),
                    ),
                  ],
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool datosValidos() {
    bool result = false;
    if (selectTapaPiston == SelectTapaPiston.tapa) {
      if (parseStable(_d1min.text) >= 0 &&
          parseStable(_D2max.text) >= 0 &&
          parseStable(_D3max.text) >= 0 &&
          parseStable(_Smin.text) >= 0 &&
          parseStable(_D3min.text) >= 0) {
        result = true;
      }
    } else if (selectTapaPiston == SelectTapaPiston.piston) {
      if (parseStable(_D1max.text) >= 0 &&
          parseStable(_d2min.text) >= 0 &&
          parseStable(_d3max.text) >= 0 &&
          parseStable(_d3min.text) >= 0 &&
          parseStable(_Smax.text) >= 0 &&
          parseStable(_di.text) >= 0 &&
          parseStable(_Smin.text) >= 0) {
        result = true;
      }
    }
    return result;
  }

  double parseStable(String number) {
    double result = 0;
    try {
      result = double.parse(number);
      return result;
    } catch (e) {
      return -1;
    }
  }

  void calcularGAP(BuildContext context) {
    String titulo = '';
    String mensajeSistema = '';

    if (selectTapaPiston == SelectTapaPiston.tapa) {
      D2max = double.parse(_D2max.text);
      D3max = double.parse(_D3max.text);
      Smin = double.parse(_Smin.text);
      d1min = double.parse(_d1min.text);
      D3min = double.parse(_D3min.text);

      titulo = 'El calculo de la Tapa es:';
      GAPmax = ((D2max + D3max) / 2.0) - Smin - d1min;
      GAPmin = Smin - ((D2max - D3min) / 2.0);
    } else if (selectTapaPiston == SelectTapaPiston.piston) {
      D1max = double.parse(_D1max.text);
      d2min = double.parse(_d2min.text);
      d3max = double.parse(_d3max.text);
      d3min = double.parse(_d3min.text);
      Smax = double.parse(_Smax.text);
      di = double.parse(_di.text);
      Smin = double.parse(_Smin.text);
      titulo = 'El calculo de la Pistón';
      GAPmax = D1max - Smax - ((d3min + d2min) / 2.0) + di;
      GAPmin = Smin - ((d3max - d2min) / 2.0);
    }

    if (sistema == SelectSistema.SI) {
      if (GAPmin < 0.1) {
        mensajeSistema = 'El GAP mínimo no cumple el limite establecido';
      } else {
        mensajeSistema = 'El GAP mínimo cumple el limite establecido';
      }
    } else if (sistema == SelectSistema.STI) {
      if (GAPmin < 0.004) {
        mensajeSistema = 'El GAP mínimo no cumple el limite establecido';
      } else {
        mensajeSistema = 'El GAP mínimo cumple el limite establecido';
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(
              'El GAP máximo es: ${GAPmax.toStringAsFixed(6)} \nEl GAP mínimo es: ${GAPmin.toStringAsFixed(6)} \n$mensajeSistema'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }
}

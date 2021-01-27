import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'image_viewer.dart';

/// Dart import
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DataGridDemo(),
    );
  }
}

/// Renders datagrid with selection option(single/multiple and select/unselect)
class DataGridDemo extends StatefulWidget {
  /// Creates datagrid with selection option(single/multiple and select/unselect)
  const DataGridDemo({Key key}) : super(key: key);

  @override
  _DataGridDemoState createState() => _DataGridDemoState();
}

List<Product> _productData;
final math.Random _random = math.Random();

class _DataGridDemoState extends State<DataGridDemo> {
  _DataGridDemoState();

  final GlobalKey _dataGridKey = GlobalKey();
  final _CustomDataGridSource _customDataGridSource = _CustomDataGridSource();

  static double rowHeight = 49.0;
  static double headerRowHeight = 56.0;
  static double columnWidth = 90;

  List<GridColumn> _columns;

  bool chnageToImage = false;

  @override
  void initState() {
    super.initState();
    _productData = generateList(50);
    _columns = getColumns();
  }

  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridNumericColumn(mappingName: 'id', headerText: 'ID'),
      GridNumericColumn(mappingName: 'productId', headerText: 'Product ID'),
      GridTextColumn(mappingName: 'name', headerText: 'Customer Name'),
      GridTextColumn(mappingName: 'product', headerText: 'Product'),
      GridDateTimeColumn(
          mappingName: 'orderDate',
          dateFormat: DateFormat('MM/dd/yyyy'),
          headerText: 'Order Date'),
      GridNumericColumn(mappingName: 'quantity', headerText: 'Quantity'),
      GridTextColumn(mappingName: 'city', headerText: 'City'),
      GridNumericColumn(
        mappingName: 'unitPrice',
        numberFormat: NumberFormat.currency(locale: 'en_US', symbol: '\$'),
        headerText: 'Unit Price',
      )
    ];
    return columns;
  }

  Future<void> captureImage() async {
    try {
      setState(() {
        chnageToImage = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final RenderRepaintBoundary boundary =
              _dataGridKey.currentContext.findRenderObject();
          final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
          final ByteData byteData =
              await image.toByteData(format: ui.ImageByteFormat.png);
          final pngBytes = byteData.buffer.asUint8List();
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ImageViewPage(
                        imageData: pngBytes,
                        byteData: byteData,
                        dataGridHeight:
                            (_productData.length * rowHeight) + headerRowHeight,
                        dataGridWidth: (_columns.length * columnWidth),
                      ))));
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImageView() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RepaintBoundary(
            key: _dataGridKey,
            child: Container(
              height: (_productData.length * rowHeight) + headerRowHeight,
              width: (_columns.length * columnWidth),
              child:
                  SfDataGrid(source: _customDataGridSource, columns: _columns),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    final button = FlatButton(
      child: Text('Convert to Image'),
      onPressed: captureImage,
    );

    children.add(button);

    if (chnageToImage) {
      children.add(_buildImageView());
    } else {
      children.add(Expanded(
          child: SfDataGrid(source: _customDataGridSource, columns: _columns)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('DataGrid Demo'),
      ),
      body: Column(
        children: children,
      ),
    );
  }
}

class Product {
  Product(this.id, this.productId, this.product, this.quantity, this.unitPrice,
      this.city, this.orderDate, this.name);
  final int id;
  final int productId;
  final String product;
  final int quantity;
  final double unitPrice;
  final String city;
  final DateTime orderDate;
  final String name;
}

class _CustomDataGridSource extends DataGridSource<Product> {
  _CustomDataGridSource();

  @override
  List<Product> get dataSource => _productData;
  @override
  Object getValue(Product _product, String columnName) {
    switch (columnName) {
      case 'id':
        return _product.id;
        break;
      case 'product':
        return _product.product;
        break;
      case 'productId':
        return _product.productId;
        break;
      case 'unitPrice':
        return _product.unitPrice;
        break;
      case 'quantity':
        return _product.quantity;
        break;
      case 'city':
        return _product.city;
        break;
      case 'orderDate':
        return _product.orderDate;
        break;
      case 'name':
        return _product.name;
        break;
      default:
        return 'empty';
        break;
    }
  }
}

final List<String> _product = <String>[
  'Lax',
  'Chocolate',
  'Syrup',
  'Chai',
  'Bags',
  'Meat',
  'Filo',
  'Cashew',
  'Walnuts',
  'Geitost',
  'Cote de',
  'Crab',
  'Chang',
  'Cajun',
  'Gum',
  'Filo',
  'Cashew',
  'Walnuts',
  'Geitost',
  'Bag',
  'Meat',
  'Filo',
  'Cashew',
  'Geitost',
  'Cote de',
  'Crab',
  'Chang',
  'Cajun',
  'Gum',
];

final List<String> _cities = <String>[
  'Bruxelles',
  'Rosario',
  'Recife',
  'Graz',
  'Montreal',
  'Tsawassen',
  'Campinas',
  'Resende',
];

final List<int> _productId = <int>[
  3524,
  2523,
  1345,
  5243,
  1803,
  4932,
  6532,
  9475,
  2435,
  2123,
  3652,
  4523,
  4263,
  3527,
  3634,
  4932,
  6532,
  9475,
  2435,
  2123,
  6532,
  9475,
  2435,
  2123,
  4523,
  4263,
  3527,
  3634,
  4932,
];

final List<DateTime> _orderDate = <DateTime>[
  DateTime.now(),
  DateTime(2002, 8, 27),
  DateTime(2015, 7, 4),
  DateTime(2007, 4, 15),
  DateTime(2010, 12, 23),
  DateTime(2010, 4, 20),
  DateTime(2004, 6, 13),
  DateTime(2008, 11, 11),
  DateTime(2005, 7, 29),
  DateTime(2009, 4, 5),
  DateTime(2003, 3, 20),
  DateTime(2011, 3, 8),
  DateTime(2013, 10, 22),
];

List<String> _names = [
  'Kyle',
  'Gina',
  'Irene',
  'Katie',
  'Michael',
  'Oscar',
  'Ralph',
  'Torrey',
  'William',
  'Bill',
  'Daniel',
  'Frank',
  'Brenda',
  'Danielle',
  'Fiona',
  'Howard',
  'Jack',
  'Larry',
  'Holly',
  'Jennifer',
  'Liz',
  'Pete',
  'Steve',
  'Vince',
  'Zeke'
];

List<Product> generateList(int count) {
  final List<Product> productData = <Product>[];
  for (int i = 0; i < count; i++) {
    productData.add(
      Product(
          i + 1000,
          _productId[_random.nextInt(10)],
          _product[_random.nextInt(10)],
          _random.nextInt(10),
          70.0 + _random.nextInt(10),
          _cities[i < _cities.length ? i : _random.nextInt(_cities.length - 1)],
          _orderDate[_random.nextInt(_orderDate.length - 1)],
          _names[_random.nextInt(10)]),
    );
  }

  return productData;
}

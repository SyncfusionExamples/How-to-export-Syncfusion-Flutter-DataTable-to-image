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

  @override
  _DataGridDemoState createState() => _DataGridDemoState();
}

List<Product>? _productData;
final math.Random random = math.Random();

class _DataGridDemoState extends State<DataGridDemo> {
  final _dataGridKey = GlobalKey();
  late _CustomDataGridSource _customDataGridSource;

  static double rowHeight = 49.0;
  static double headerRowHeight = 56.0;
  static double columnWidth = 90;

  late List<GridColumn> _columns;

  bool changeToImage = false;

  final List<String> product = <String>[
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

  final List<String> cities = <String>[
    'Bruxelles',
    'Rosario',
    'Recife',
    'Graz',
    'Montreal',
    'Tsawassen',
    'Campinas',
    'Resende',
  ];

  final List<int> productId = <int>[
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

  final List<DateTime> orderDate = <DateTime>[
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

  List<String> names = [
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

  @override
  void initState() {
    super.initState();
    _productData = generateList(25);
    _columns = getColumns();
    _customDataGridSource = _CustomDataGridSource(productData: _productData!);
  }

  List<Product> generateList(int count) {
    final List<Product> productData = <Product>[];
    for (int i = 0; i < count; i++) {
      productData.add(
        Product(
            i + 1000,
            productId[i],
            product[i],
            random.nextInt(20),
            70.0 + random.nextInt(100),
            cities[i < cities.length ? i : random.nextInt(cities.length - 1)],
            orderDate[random.nextInt(orderDate.length - 1)],
            names[i]),
      );
    }
    return productData;
  }

  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridTextColumn(
          columnName: 'id',
          width: 90,
          label: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'ID',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridTextColumn(
          columnName: 'productId',
          width: 100,
          label: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Product ID',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'name',
          width: 140,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Customer Name',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'product',
          width: 100,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Product',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'orderDate',
          width: 110,
          label: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Order Date',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'quantity',
          width: 90,
          label: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Quantity',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'city',
          width: 100,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'City',
              overflow: TextOverflow.ellipsis,
            ),
          )),
      GridColumn(
          columnName: 'unitPrice',
          width: 100,
          label: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Unit Price',
              overflow: TextOverflow.ellipsis,
            ),
          )),
    ];
    return columns;
  }

  Future<void> captureImage() async {
    try {
      setState(() {
        changeToImage = true;
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
          final dynamic boundary =
              _dataGridKey.currentContext!.findRenderObject();
          //   final RenderRepaintBoundary boundary =
          // _dataGridKey.currentContext.findRenderObject();
          final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
          final ByteData byteData =
              (await image.toByteData(format: ui.ImageByteFormat.png))!;
          final pngBytes = byteData.buffer.asUint8List();
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ImageViewPage(
                        imageData: pngBytes,
                        byteData: byteData,
                        dataGridHeight: (_productData!.length * rowHeight) +
                            headerRowHeight,
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
              height: (_productData!.length * rowHeight) + headerRowHeight,
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
    final button = MaterialButton(
      child: Text('Convert to Image'),
      onPressed: captureImage,
    );

    children.add(button);

    if (changeToImage) {
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

class _CustomDataGridSource extends DataGridSource {
  _CustomDataGridSource({required List<Product> productData}) {
    _productData = productData.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'id', value: e.id),
        DataGridCell(columnName: 'productId', value: e.productId),
        DataGridCell(columnName: 'name', value: e.name),
        DataGridCell(columnName: 'product', value: e.product),
        DataGridCell(columnName: 'orderDate', value: e.orderDate),
        DataGridCell(columnName: 'quantity', value: e.quantity),
        DataGridCell(columnName: 'city', value: e.city),
        DataGridCell(columnName: 'unitPrice', value: e.unitPrice),
      ]);
    }).toList(growable: false);
  }

  late List<DataGridRow> _productData;

  @override
  List<DataGridRow> get rows => _productData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          DateFormat('MM/dd/yyyy').format(row.getCells()[4].value).toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[5].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[6].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(8.0),
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: '\$')
              .format(row.getCells()[7].value)
              .toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }
}

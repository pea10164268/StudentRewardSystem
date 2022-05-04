import 'package:flutter/material.dart';

class Class extends StatefulWidget {
  const Class({Key? key}) : super(key: key);

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  final List<Map> _class = [
    {
      'id': 1,
      'classname': 'year 1 english',
      'description': 'english for year 1 students',
      'teacherid': '1',
    },
    {
      'id': 2,
      'classname': 'year 1 english',
      'description': 'english for year 1 students',
      'teacherid': '1',
    },
    {
      'id': 3,
      'classname': 'year 1 english',
      'description': 'english for year 1 students',
      'teacherid': '1',
    },
  ];

  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Class',
              style: TextStyle(
                fontSize: 30,
              )),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(32),
          children: [_createDataTable()],
        ));
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      sortColumnIndex: _currentSortColumn,
      sortAscending: _isSortAsc,
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: const Text('ID'),
        onSort: (columnIndex, _) {
          setState(() {
            _currentSortColumn = columnIndex;
            if (_isSortAsc) {
              _class.sort((a, b) => b['id'].compareTo(a['id']));
            } else {
              _class.sort((a, b) => a['id'].compareTo(b['id']));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
      ),
      const DataColumn(label: Text('Class Name')),
      const DataColumn(label: Text('Description')),
      const DataColumn(label: Text('TeacherID')),
    ];
  }

  List<DataRow> _createRows() {
    return _class
        .map((classroom) => DataRow(cells: [
              DataCell(Text('#' + classroom['id'].toString())),
              DataCell(Text(classroom['classname'])),
              DataCell(Text(classroom['description'])),
              DataCell(Text(classroom['teacherid']))
            ]))
        .toList();
  }
}

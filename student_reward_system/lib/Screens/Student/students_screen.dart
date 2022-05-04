import 'package:flutter/material.dart';

class Students extends StatefulWidget {
  const Students({Key? key}) : super(key: key);

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  final List<Map> _students = [
    {
      'id': '1',
      'firstname': 'Sally',
      'lastname': 'Webster',
      'classid': '2eng',
    },
    {
      'id': '2',
      'firstname': 'Gail',
      'lastname': 'Platt',
      'classid': '2eng',
    },
    {
      'id': '3',
      'firstname': 'Ken',
      'lastname': 'Barlow',
      'classid': '5mat',
    },
    {
      'id': '4',
      'firstname': 'Sally',
      'lastname': 'Webster',
      'classid': '6sci',
    }
  ];
  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Students',
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
              _students.sort((a, b) => b['id'].compareTo(a['id']));
            } else {
              _students.sort((a, b) => a['id'].compareTo(b['id']));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
      ),
      const DataColumn(label: Text('First Name')),
      const DataColumn(label: Text('Last Name')),
      const DataColumn(label: Text('ClassID')),
    ];
  }

  List<DataRow> _createRows() {
    return _students
        .map((student) => DataRow(cells: [
              DataCell(Text('#' + student['id'].toString())),
              DataCell(Text(student['firstname'])),
              DataCell(Text(student['lastname'])),
              DataCell(Text(student['classid']))
            ]))
        .toList();
  }
}

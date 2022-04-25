import 'package:flutter/material.dart';

class Teachers extends StatefulWidget {
  const Teachers({Key? key}) : super(key: key);

  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  final List<Map> _teachers = [
    {
      'id': 1,
      'firstname': 'John',
      'lastname': 'jameson',
      'classid': '2eng',
    },
    {
      'id': 2,
      'firstname': 'Harry',
      'lastname': 'Parker',
      'classid': '5mat',
    },
    {
      'id': 3,
      'firstname': 'Sarah',
      'lastname': 'wells',
      'classid': '6pe',
    },
    {
      'id': 4,
      'firstname': 'Buddy',
      'lastname': 'wellington',
      'classid': '4geo',
    }
  ];

  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Teachers',
              style: TextStyle(
                fontSize: 30,
              )),
          centerTitle: true,
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
              _teachers.sort((a, b) => b['id'].compareTo(a['id']));
            } else {
              _teachers.sort((a, b) => a['id'].compareTo(b['id']));
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
    return _teachers
        .map((teacher) => DataRow(cells: [
              DataCell(Text('#' + teacher['id'].toString())),
              DataCell(Text(teacher['firstname'])),
              DataCell(Text(teacher['lastname'])),
              DataCell(Text(teacher['classid']))
            ]))
        .toList();
  }
}

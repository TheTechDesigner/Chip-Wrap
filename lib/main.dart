import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFC41A3B),
        primaryColorLight: Color(0xFFFBE0E6),
        accentColor: Color(0xFF1B1F32),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  bool isSend = false;
  bool isOnData = false;
  bool isSelected = false;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = 'Chips & Wrap Widgets';

  List<String> _dynamicChips;
  int _defaultChoice;
  List<String> _choices;
  bool _isSelected;
  List<String> _filter;
  List<Companies> _companies;

  @override
  void initState() {
    super.initState();
    _dynamicChips = ['Computer', 'Mobile', 'Gadgets'];
    _defaultChoice = 0;
    _choices = [
      'Choice 1',
      'Choice 2',
      'Choice 3',
      'Choice 4',
    ];
    _isSelected = false;
    _filter = <String>[];
    _companies = <Companies>[
      Companies('Nokia'),
      Companies('IPhone'),
      Companies('Nexus'),
      Companies('Realme'),
      Companies('LG'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Divider(),
            Text('Chip, Wrap Widget'),
            Wrap(
              spacing: 8.0,
              runSpacing: 2.0,
              children: <Widget>[
                _chip('Science', Colors.red),
                _chip('Adventure', Colors.green),
                _chip('Drama', Colors.orange),
                _chip('Thriller', Colors.yellow),
                _chip('Comedy', Colors.black38),
                _chip('Action', Colors.blue),
              ],
            ),
            Divider(),
            Text('Dynamic Chips'),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children:
                  List<Widget>.generate(_dynamicChips.length, (int index) {
                return Chip(
                  label: Text(_dynamicChips[index]),
                  onDeleted: () {
                    setState(() {
                      _dynamicChips.removeAt(index);
                    });
                  },
                );
              }),
            ),
            Divider(),
            Text('Action Chips'),
            Wrap(
              children: <Widget>[
                ActionChip(
                  onPressed: () {
                    print('Sending...');
                  },
                  avatar: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.share,
                      size: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  label: Text('Send'),
                  backgroundColor: Colors.white,
                  elevation: 5.0,
                  padding: EdgeInsets.all(2.0),
                  shape: StadiumBorder(
                      side: BorderSide(width: 2.0, color: Colors.red)),
                ),
                SizedBox(width: 8.0),
                ActionChip(
                  onPressed: () {
                    setState(() {
                      widget.isSend = !widget.isSend;
                    });
                  },
                  avatar: widget.isSend
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : null,
                  label: Text('${widget.isSend ? 'Sending...' : 'Send'}'),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Divider(),
            Text('Choice Chips'),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _choices.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ChoiceChip(
                        selected: _defaultChoice == index,
                        // selectedColor: Colors.red,
                        label: Text(_choices[index]),
                        // labelStyle: TextStyle(color: Colors.white),
                        // backgroundColor: Colors.grey,
                        onSelected: (bool selected) {
                          setState(() {
                            _defaultChoice = selected ? index : 0;
                          });
                        },
                      ),
                    );
                  }),
            ),
            Divider(),
            Text('Input Chips'),
            Wrap(
              children: <Widget>[
                InputChip(
                  label: Text('Mobile Data'),
                  labelStyle: TextStyle(
                      fontSize: 14.0,
                      color: widget.isOnData ? Colors.black : Colors.white),
                  padding: EdgeInsets.all(8.0),
                  pressElevation: 24.0,
                  selected: widget.isOnData,
                  selectedColor: Colors.red,
                  selectedShadowColor: Colors.red[200],
                  checkmarkColor: Colors.white,
                  onSelected: (isSelected) {
                    setState(() {
                      widget.isOnData = !widget.isOnData;
                    });
                  },
                ),
                SizedBox(width: 8.0),
                InputChip(
                  label: Text('The Tech Designer'),
                  padding: EdgeInsets.all(2.0),
                  selected: _isSelected,
                  selectedColor: Colors.red,
                  onSelected: (bool selected) {
                    setState(() {
                      _isSelected = selected;
                    });
                  },
                  onDeleted: () {},
                  avatar: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Text(
                      'TD',
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Text('Filter Chips Without Avatar'),
            Wrap(
              children: <Widget>[
                //Disable
                FilterChip(
                  selected: false,
                  onSelected: (bool selected) {
                    setState(() {});
                  },
                  label: Text('Computer'),
                ),
                SizedBox(width: 8.0),
                FilterChip(
                  checkmarkColor: Colors.white,
                  selected: widget.isSelected,
                  selectedColor: Colors.red,
                  onSelected: (bool selected) {
                    setState(() {
                      widget.isSelected = !widget.isSelected;
                    });
                  },
                  label: Text('Mobile'),
                  labelStyle: TextStyle(
                      color: widget.isSelected ? Colors.black : Colors.white),
                )
              ],
            ),
            Divider(),
            Text('Filter Chips'),
            Wrap(
              children: _companyList.toList(),
            ),
            Text('Selected Company : ${_filter.join(', ')}'),
          ],
        ),
      ),
    );
  }

  Iterable<Widget> get _companyList sync* {
    for (Companies company in _companies) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
            label: Text(company.name),
            avatar: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(
                company.name[0].toUpperCase(),
              ),
            ),
            selected: _filter.contains(company.name),
            selectedColor: Colors.green,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _filter.add(company.name);
                } else {
                  _filter.removeWhere((String name) {
                    return name == company.name;
                  });
                }
              });
            }),
      );
    }
  }

  Widget _chip(String label, Color color) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.black54,
        child: Text(
          label[0].toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      labelPadding: EdgeInsets.all(4.0),
      backgroundColor: color,
      shadowColor: Colors.grey[80],
      elevation: 5.0,
      padding: EdgeInsets.all(4.0),
    );
  }
}

class Companies {
  Companies(this.name);
  String name;
}

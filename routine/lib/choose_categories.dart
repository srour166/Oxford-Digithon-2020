import 'package:flutter/material.dart';

class ChooseCategories extends StatefulWidget {
  const ChooseCategories();
  @override
  _ChooseCategoriesState createState() => _ChooseCategoriesState();
}

class _ChooseCategoriesState extends State<ChooseCategories> {
  List<int> selectedpics = [];
  Widget _donebutton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {},
        padding: EdgeInsets.all(15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        child: Text(
          'DONE',
          style: TextStyle(
              color: Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pick your interests'),
      ),
      body: new GridView.extent(
          maxCrossAxisExtent: 250.0,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          padding: const EdgeInsets.all(5.0),
          children: [..._buildGridTiles(8), _donebutton()]),
    );
  }

  List<Widget> _buildGridTiles(numberOfTiles) {
    List<Container> containers =
        new List<Container>.generate(numberOfTiles, (int index) {
      final imageName = index < 9
          ? 'images/image0${index + 1}.jpeg'
          : 'images/image${index + 1}.jpeg';
      return new Container(
        child: GestureDetector(
            onTap: () {
              setState(() {
                if (selectedpics.contains(index)) {
                  selectedpics.remove(index);
                } else {
                  selectedpics.add(index);
                }
              });
              print("pressing image");
            },
            child: selectedpics.contains(index)
                ? ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.red[100], BlendMode.modulate),
                    child: Image.asset(imageName, fit: BoxFit.fill))
                : Image.asset(imageName, fit: BoxFit.fill)),
      );
    });
    return containers;
  }
}

@override
Widget build(BuildContext context) {
  throw UnimplementedError();
}

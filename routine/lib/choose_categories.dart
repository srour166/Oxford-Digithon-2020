import 'package:flutter/material.dart';
import 'package:routine/utils/firebase.dart';
import 'package:routine/utils/ActivityCategory.dart';

class ChooseCategories extends StatefulWidget {
  const ChooseCategories();
  @override
  _ChooseCategoriesState createState() => _ChooseCategoriesState();
}

class _ChooseCategoriesState extends State<ChooseCategories> {
  List<ActivityCategory> categories = [];
  List<ActivityCategory> selectedCategories = [];

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
      body: FutureBuilder<List<ActivityCategory>>(
          future: FirebaseUtils().getCategories(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();

            int numberOfTiles = snapshot.data.length;
            return Column(
              children: <Widget>[
                GridView.builder(
                    itemCount: numberOfTiles,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    padding: const EdgeInsets.all(5.0),
                    itemBuilder: (ctxt, index) {
                      ActivityCategory category = categories[index];
                      final imageName = category.imageUrl;

                      return Container(
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedCategories.contains(category)) {
                                  selectedCategories.remove(category);
                                } else {
                                  selectedCategories.add(category);
                                }
                              });
                            },
                            child: selectedCategories.contains(index)
                                ? ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        Colors.red[100], BlendMode.modulate),
                                    child: Image.network(imageName,
                                        fit: BoxFit.fill))
                                : Image.asset(imageName, fit: BoxFit.fill)),
                      );
                    }),
                _donebutton(),
              ],
            );
          }),
    );
  }
}

@override
Widget build(BuildContext context) {
  throw UnimplementedError();
}

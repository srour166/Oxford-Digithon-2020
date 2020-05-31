import 'package:flutter/material.dart';
import 'package:routine/dashboard.dart';
import 'package:routine/utils/firebase.dart';
import 'package:routine/utils/ActivityCategory.dart';
import 'package:routine/utils/helpers.dart';

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
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF73AEF5),
          Color(0xFF61A4F1),
          Color(0xFF478DE0),
          Color(0xFF398AE5),
        ],
        stops: [0.1, 0.4, 0.7, 0.9],
      )),
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              )),
          padding: EdgeInsets.all(10),
          child: Text(
            'DONE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        onTap: () async {
          if (!(await FirebaseUtils().setUserPreferences(selectedCategories))) {
            await showAlertDialog(context,
                title: 'Error saving interests',
                message:
                    'There was an error saving your interests. Please try again later!');
          } else {
            await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctxt) => MyDashboardPage()));
          }
        },
      ),
    );
  }

  Future<List<ActivityCategory>> getCategories() async {
    if (categories.isEmpty) {
      categories = await FirebaseUtils().getCategories();
    }

    return categories;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUtils().getUserPreferences();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Pick your interests'),
        ),
        bottomNavigationBar: _donebutton(),
        body: Stack(children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ))),
          FutureBuilder<List<ActivityCategory>>(
              future: getCategories(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();

                int numberOfTiles = snapshot.data.length;
                return GridView.builder(
                    itemCount: numberOfTiles,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    padding: const EdgeInsets.all(5.0),
                    itemBuilder: (ctxt, index) {
                      ActivityCategory category = snapshot.data[index];
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
                            child: selectedCategories.contains(category)
                                ? ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        Colors.red[100], BlendMode.modulate),
                                    child: Image.network(imageName,
                                        fit: BoxFit.fill))
                                : Image.network(imageName, fit: BoxFit.fill)),
                      );
                    });
              }),
        ]));
  }
}

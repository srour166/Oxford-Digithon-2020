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
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
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

  Future<List<ActivityCategory>> getCategories() async {
    if (categories.isEmpty) {
      categories = await FirebaseUtils().getCategories();
    }

    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pick your interests'),
      ),
      bottomNavigationBar: _donebutton(),
      body: FutureBuilder<List<ActivityCategory>>(
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
                                child:
                                    Image.network(imageName, fit: BoxFit.fill))
                            : Image.network(imageName, fit: BoxFit.fill)),
                  );
                });
          }),
    );
  }
}

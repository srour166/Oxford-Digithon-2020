import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routine/utils/Category.dart';

class ChooseCategories extends StatefulWidget {
  @override
  _ChooseCategoriesState createState() => _ChooseCategoriesState();
}

class _ChooseCategoriesState extends State<ChooseCategories> {
  final List<Category> categories = [
    Category(
      description: 'test',
      name: 'test',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Category(
      description: 'test 2',
      name: 'test 2',
      imageUrl: 'https://via.placeholder.com/150',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your categories'),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(
                    categories[index].imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topCenter,
                    child: Text(
                      categories[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.2,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}

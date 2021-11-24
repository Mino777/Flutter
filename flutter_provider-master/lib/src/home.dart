import 'package:flutter/material.dart';
import 'package:flutter_provider/src/provider/bottom_navigation_provider.dart';
import 'package:flutter_provider/src/provider/count_provider.dart';
import 'package:flutter_provider/src/ui/count_home_widget.dart';
import 'package:flutter_provider/src/ui/movie_list_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  late CountProvider _countProvider;
  late BottomNavigationProvider _bottomNavigationProvider;

  @override
  Widget build(BuildContext context) {
    _countProvider = Provider.of<CountProvider>(context, listen: false);
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);
    return Scaffold(
      body: navigationBody(),
      bottomNavigationBar: bottomNavigationBarWidget(),
    );
  }

  Widget navigationBody() {

    switch(_bottomNavigationProvider.currentNavigationIndex) {
      case 0:
        return CountHomeWidget();
        break;
      case 1:
        return MovieListWidget();
        break;
    }

    return Container(

    );
  }

  Widget bottomNavigationBarWidget() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movie")
      ],
      currentIndex: _bottomNavigationProvider.currentNavigationIndex,
      selectedItemColor: Colors.red,
      onTap: (index) {
        // provider navigation state
        _bottomNavigationProvider.updatePage(index);
        print(_bottomNavigationProvider.currentNavigationIndex);
        print(index);
      },
    );
  }
}
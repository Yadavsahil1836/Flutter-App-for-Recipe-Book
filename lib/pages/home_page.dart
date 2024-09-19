import 'package:firebase/models/receips.dart';
import 'package:firebase/pages/recipepage.dart';
import 'package:firebase/services/data_service.dart';
import 'package:flutter/material.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {

  String _mealtype = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: const Text('Home Page',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
        ),
        

      ),
      body: SafeArea(child: _bulidui()),
    );
  }

  Widget _bulidui(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _recipptype(),
          _reciptlist(),
        ],
      ),
    );
  }

  Widget _recipptype(){
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealtype = 'Snack';
                });
              },
              child: const Text('Snack')
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealtype = 'breakfast';
                });
              },
              child: const Text('Breakfast')
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealtype = 'Lunch';
                });
              },
              child: const Text('Lunch')
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealtype = 'dinner';
                });
              },
              child: const Text('Dinner')
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _reciptlist(){
    return Expanded(
      child: FutureBuilder(future: DataService().getRecipes(_mealtype,
      ), builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasError){
          return const  Center(child: Text('Unable to load data'),);
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context,index){
            Recipes recipe = snapshot.data![index];
            return ListTile(
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context){
                  return Recipepage(recipe: recipe,);
                }
                )
                );
              },
              contentPadding: const EdgeInsets.only(top: 20.0),
              isThreeLine: true,
              subtitle: Text(
                "${recipe.cuisine}\nDifficulty: ${recipe.difficulty}",
              ),
              leading: Image.network(recipe.image),
              title: Text(
                recipe.name
              ),
              trailing: Text("${recipe.rating.toString()} ⭐",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),),
            );
          });
      }
      )
    );
  }
}
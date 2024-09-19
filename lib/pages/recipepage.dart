import 'package:firebase/models/receips.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Recipepage extends StatelessWidget {
 
  final Recipes recipe;

  Recipepage({
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white60,
        title: const Text('Recipe Details'),
      ),
      body: _bulidui(context),
    );
  }

  Widget _bulidui(context){
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeimage(context
          ,),
         _recipeDetails(context,),
      
         _recipeingren(context,),
      
         _recipeinst(context),
        ],
      ),
    );
  }

  Widget _recipeimage(BuildContext context){
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(recipe.image))
      ),
    );

  }

  Widget _recipeDetails(BuildContext context){
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${recipe.cuisine}, ${recipe.difficulty}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300
          ),
          ),
          Text(
            recipe.name,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          Text("Prep time: ${recipe.prepTimeMinutes} Minutes | Cook Time: ${recipe.cookTimeMinutes} Minutes",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w300
          ),
          ),
          Text("${recipe.rating.toString()} ⭐| ${recipe.reviewCount} Reviews",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500
          ),
          ),
        ],
      ),
    );

  }

  Widget _recipeingren(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0
      ),
      child: Column(
        children: recipe.ingredients.map((i){
          return Row(
            children: [
               const Icon(
                Icons.check_box,  
               ),
               Text("$i")
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _recipeinst(BuildContext context){
    return Container(
      color:  Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0
      ),
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: recipe.instructions.map((i)
         {
          return Text(
            "${recipe.instructions.indexOf(i)}. $i\n",
            maxLines: 3,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 15.0
          ),);
            },
            ).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:baseball_cards/presentation/widgets/item_card_swiper.dart';
import 'package:card_swiper/card_swiper.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      //APPBAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Mis cartas', 
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold,
            fontSize: 24,
          )
        ),
        actions: [

          //BUSCAR
          _SearchButton(),

          SizedBox(width: 4,),
          // PERFIL DE USUARIO
          _ProfileButton(),

          SizedBox(width: 16,),
        ],
      ),

      // BODY
      //backgroundColor: Colors.amber,
      body: Column(
        children: [

          SizedBox(height: 20,),

          _CollectionsFilters(),
  
          SizedBox(height: 20,),
      
          _CardSwipper(),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // backgroundColor: Colors.red,
        onPressed: () {

          //TODO: implementar creación de nueva carta
        
        },
      )
    );
  }
}

class _SearchButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search, color: Colors.black),
      onPressed: (){

        //TODO: implementar el delegate de busqueda

      }, 
    );
  }
}

class _ProfileButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        child: Icon(Icons.person),
        backgroundColor: Colors.black12,
        foregroundColor: Colors.black,
      ),
      onPressed: (){

        //TODO: implementar perfil de usuario

      },
    );
  }
}

class _CollectionsFilters extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      // color: Colors.red,
      // width: double.infinity,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: ( _ , index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: InputChip(
              selectedColor: Colors.blue,
              backgroundColor: Colors.grey[200],
              label: Text('hola'), 
              selected: false,
              onSelected: (value){

                //TODO: filtrar por colección seleccionado

              }
            ),
          );
        }
      ),
    );
  }
}


class _CardSwipper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
    
      height: size.height * 0.7,

      child: Swiper(
        itemCount: 10,
        viewportFraction: 0.8,
        scale: 0.9,
        itemBuilder: (BuildContext context,int index){

          return CardItem(
            firstName: 'Juan Roman',
            lastName: 'Riquelme',
          );

        },
      ),
    );
  }
}
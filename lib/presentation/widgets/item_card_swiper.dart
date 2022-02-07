
import 'package:flutter/material.dart';

import 'package:baseball_cards/models/card.dart' as baseball_card;


class CardItem extends StatelessWidget {

  final baseball_card.Card card;
  final Function()? onTap;

  const CardItem({
    Key? key, 
    required this.card, 
    required this.onTap, 

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      
      onTap: this.onTap,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                

                _ImageInCard( 
                  urlImage:  ( this.card.image == "") 
                    ? 'https://via.placeholder.com/200x200'
                    : this.card.image!
                ),
          
                const SizedBox(height: 16,),
          
                //rarity of card
                Text( this.card.rarities.description, 
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
    
                const SizedBox(height: 10,),
    
                //First and Last name of player
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text( '${this.card.player.lastName} ${this.card.player.firstName}', 
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1, ),
                ),
          
                SizedBox(height: 12,),
          
                _TeamAndRolPanel(
                  team: this.card.team.teamName,
                  rolPlayer: this.card.rolPlayer.nameRole,
                ),
    
                SizedBox(height: 24,),
                
              ],
            ),
          
          ),
        ],
      ),
    );
  }
}

class _TeamAndRolPanel extends StatelessWidget {

  final String team;
  final String rolPlayer;

  const _TeamAndRolPanel({
    Key? key, 
    required this.team, 
    required this.rolPlayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.grey.shade100
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //TODO: CAMBIAR ICONOS 
            children: [
              _IconInfoItem(text: this.team, icon: Icons.access_alarm_outlined),
              _IconInfoItem(text: this.rolPlayer, icon: Icons.connected_tv),
            ]
          ),
        ),
      ),
    );
  }
}

class _IconInfoItem extends StatelessWidget {

  final String text;
  final IconData icon;

  const _IconInfoItem({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [

          Icon(
            icon,
            size: 24,
          ),
          
          const SizedBox(height: 12,),
    
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ImageInCard extends StatelessWidget {

  final String urlImage;

  const _ImageInCard({
    Key? key,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      child: FadeInImage(
        fit: BoxFit.cover,
        placeholder: const AssetImage('assets/baseball_loading.gif'),
        image: NetworkImage(this.urlImage),
      ),
    );
  }
}

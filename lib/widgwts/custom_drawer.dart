import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(      
      child: ListView(        
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              image: DecorationImage(
                image: NetworkImage(
                  "https://antenasur.com.ec/wp-content/uploads/2023/08/33728380_gradient_background_02-1-scaled.jpeg",
                  ),
                  fit: BoxFit.fill,
                ),
            
            ),
            child: Text(
              'Antena Sur - Digital',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
                      
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            trailing: const Icon(Icons.more_vert), 
            onTap: () =>Navigator.pop(context),
                        
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Social'),
            trailing: const Icon(Icons.more_vert), 
            onTap: () =>Navigator.pop(context),
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 0,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.more_vert), 
            onTap: () =>Navigator.pop(context),
          ),
        ],        
      ),
     
    );
  }
}

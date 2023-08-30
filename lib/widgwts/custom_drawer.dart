import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          //Cabecera
          const _DrawerHeader(),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            trailing: const Icon(Icons.more_vert),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Social'),
            trailing: const Icon(Icons.more_vert),
            onTap: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return const _AlertDialog();
                }),
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
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      title: const Text('DESARROLLADO POR:'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10)),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Luis Lema'),
          SizedBox(height: 10),
          FlutterLogo(size: 100)
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar')),
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('Ok')),
      ],
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
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
    );
  }
}

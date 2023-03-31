import 'package:flutter/material.dart';
import 'package:pfe/main.dart';

void main(List<String> args) {
  runApp(new MaterialApp(
    home: MyApp(),
  ));

}
class MyApp extends StatefulWidget {
  @override
  _MyAppState create() => _MyAppState();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("MENU"),
        backgroundColor: Colors.green[700],
      ),
      backgroundColor: Colors.green[100],
      drawer: new Drawer(
        child: ListView(
          children: <Widget> [
            UserAccountsDrawerHeader(
                accountName: new Text("Hadhami", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
                accountEmail: new Text("hadhami@hadhami.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://www.google.com/search?q=login+icones&sxsrf=APwXEdfPtf3q5s8RhS_vbr97d9PBDQVxfQ:1680282185874&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjJvb720ob-AhX0SfEDHbyiDGwQ_AUoAXoECAEQAw&biw=722&bih=656&dpr=1#imgrc=3_dEOPj8cEgSeM"),
                ),
              decoration: new BoxDecoration(color: Colors.purple),

      ),
          ListTile(
              leading: Icon(Icons.person),
              title: Text("Profil"),
            ),
     ListTile(
        leading: Icon(Icons.vpn_key),
        title: Text("Password"),

      ),
      ListTile(
        leading: Icon(Icons.info),
        title: Text("Information"),
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("Exit"),
      ),

      ],  ),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
            crossAxisCount: 2,
          children: <Widget>[
            MyMenu(
                title: "viewing the list",

                icon: Icons.info_outline,
                warna : Colors.blue,
            ),
            MyMenu(
              title: "change in the status",
              icon: Icons.published_with_changes,
              warna: Colors.brown,
            ),
            MyMenu(
              title: "visualization of statistics",
              icon: Icons.stacked_line_chart,
              warna: Colors.pink,
            ),
            MyMenu(
              title: "real-time order status tracking",
              icon: Icons.saved_search,
              warna: Colors.red,
            ),
            MyMenu(
              title: "Claim",
              icon: Icons.not_interested,
              warna: Colors.purple,

            ),
        MyMenu(
          title: "chat with delivery man",
          icon: Icons.chat,
          warna: Colors.grey,

        ),
            MyMenu(
                title: "contact person responsible",
                icon: Icons.contact_mail,
                warna: Colors.deepOrange)



          ]




        ),
      )
    );



  }

}
class MyMenu extends StatelessWidget {
  MyMenu({required this.title, required this.icon, required this.warna});
  final String title;
  final IconData icon;
  final MaterialColor warna;



  @override
Widget build(BuildContext context) {
    return  Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){},
        splashColor: Colors.green,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              Icon(
                icon,
                size: 70.0,
                color: warna,
              ),
              Text(title, style : new TextStyle(fontSize: 17.0))
            ],
          ),

        ),

      ),
    );

}
}
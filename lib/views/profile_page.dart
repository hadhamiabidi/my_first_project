import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _getHeader(),
            const SizedBox(height: 10,),
            _profileName(context,"Sami"),
            SizedBox(
              height: 14,
            ),
            _heading(context, "personal Détails"),
            SizedBox(
              height: 6,
            ),
            _detailsCard(),
            SizedBox(height: 10,
            ),
            _heading(context, "Settings"),
            SizedBox(
              height: 6,
            ),
            _settingsCard()

          ],
        ),
      ),
    );
  }
}

Widget _getHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2016/03/19/08/35/guy-1266366_640.jpg"
                  )

              )
          ),
        ),
      )
    ],
  );
}

Widget _profileName(BuildContext context, String name) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.80,
    child: Center(
      child: Text(
        name,
        style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
      ),
    ),
  );
}

Widget _heading(BuildContext context, String heading){
  return Container(
    width: MediaQuery.of(context).size.width *0.80,
    child: Center(
      child: Text(
        heading,
        style: TextStyle(fontSize: 16),
      ),
    ),
  );
}

Widget _detailsCard(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Sami@gmail.com"),
          ),
          Divider(
            height: 0.6,
            color: Colors.black87,
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("512456355"),
          ),
          Divider(
            height: 0.6,
            color: Colors.black87,
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text("Tunis"),
          ),
        ],
      ),

    ),
  );
}

Widget _settingsCard() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          Divider(
            height: 0.6,
            color: Colors.black87,
          ),
          ListTile(
            leading: Icon(Icons.dashboard_customize),
            title: Text("About Us"),
          ),
          Divider(
            height: 0.6,
            color: Colors.black87,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Charge Theme"),
          ),
          Divider(
            height: 0.6,
            color: Colors.black87,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          ),
        ],
      ),

    ),
  );
}

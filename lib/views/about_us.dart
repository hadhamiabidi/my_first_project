import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "À propos de nous",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "À propos de notre application de livraison",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              "Notre application de livraison est conçue spécialement pour les chauffeurs comme vous. Nous comprenons l'importance cruciale que vous jouez dans notre succès et le bonheur de nos clients.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              "Nous nous efforçons de vous fournir les outils et les fonctionnalités nécessaires pour réussir dans votre activité de livraison. Avec notre application conviviale et intuitive, vous pouvez accepter et gérer les commandes de manière efficace et optimiser vos trajets de livraison.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              "La satisfaction de nos clients est notre priorité absolue. Nous croyons fermement qu'en offrant un service exceptionnel et en veillant à ce que les clients reçoivent leurs commandes rapidement et en parfait état, nous pouvons tous réussir ensemble.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              "Rejoignez-nous dès aujourd'hui et découvrez comment notre application de livraison peut vous aider à atteindre vos objectifs professionnels tout en garantissant la satisfaction de nos précieux clients.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

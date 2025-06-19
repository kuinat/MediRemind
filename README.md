# 💊 MediRemind — Application de Gestion de Médicaments

MediRemind est une application mobile Flutter permettant aux utilisateurs de programmer des rappels pour la prise de médicaments, de suivre leur consommation quotidienne et d’éviter les oublis.

---

## 🚀 Installation & Lancement

### 📦 Prérequis

Assurez-vous d’avoir les outils suivants installés :

- ✅ [Flutter SDK](https://docs.flutter.dev/get-started/install)
- ✅ [Android Studio](https://developer.android.com/studio) ou [VS Code](https://code.visualstudio.com/) avec le plugin Flutter
- ✅ [Git](https://git-scm.com/)
- ✅ Un appareil Android réel ou un émulateur Android

---

### 📥 Cloner le projet

```bash
git clone https://github.com/kuinat/mediremind.git
cd mediremind

### Configuration initiale
💊 MediRemind — Application de Gestion de Médicaments

MediRemind est une application mobile Flutter permettant aux utilisateurs de programmer des rappels pour la prise de médicaments, de suivre leur consommation quotidienne et d’éviter les oublis.

## 🚀 Installation & Lancement

### 📦 Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android Studio ou VS Code avec les extensions Flutter/Dart
- Git
- Un émulateur Android ou un appareil Android réel

### 📥 Clonage du projet

```bash
git clone https://github.com/kuinat/mediremind.git
cd mediremind
Remplace votre-utilisateur par ton identifiant GitHub.

### 🔧 Configuration initiale

flutter pub get
flutter clean
flutter pub get
flutter pub run build_runner build

### ▶️ Lancer l'application
Connecte un appareil Android réel ou lance un émulateur

Lance le projet avec :

flutter run

### 🔔 Permissions Android
L'application requiert :

POST_NOTIFICATIONS : pour afficher les notifications (Android 13+)

SCHEDULE_EXACT_ALARM : pour planifier des rappels à heure fixe

⚠️ Sur Android 12 ou plus :

L'utilisateur devra autoriser manuellement les alarmes exactes via les paramètres du système. L'application propose automatiquement une redirection vers l'écran correspondant.

### 📂 Structure du projet
text
Copier
Modifier
lib/
 ├─ main.dart                 # Point d’entrée
 ├─ models/                  # Modèle de données : Medicine
 ├─ services/                # Base de données et notifications
 ├─ screens/                 # Interfaces utilisateur (Ajout, Liste, etc.)
 
### 🧰 Technologies utilisées
Flutter

sqflite – base locale SQLite

flutter_local_notifications – rappels planifiés

permission_handler – permissions Android

android_intent_plus – accès aux paramètres Android

### ⚠️ Problèmes fréquents
Problème	Solution
Aucune notification ne s’affiche	Vérifie les permissions dans les paramètres Android
Notification ne se déclenche pas	Active manuellement les alarmes exactes dans les paramètres système
MissingPluginException	Exécute flutter clean puis flutter pub get

### 🙋‍♀️ Contribuer
Les contributions sont bienvenues :

Signale un bug via une issue

Propose une amélioration via une pull request

### 📝 Licence
Distribué sous licence MIT. Voir le fichier LICENSE pour plus d’informations.






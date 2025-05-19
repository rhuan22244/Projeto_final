import 'package:projeto_final/consultas.page.dart';
import 'package:projeto_final/documentos_screen.dart';
import 'package:projeto_final/exames_screen.dart';
import 'package:projeto_final/farmacias_screen.dart';
import 'package:projeto_final/hospitais_screen.dart';
import 'package:projeto_final/vacinas_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/user.png'),
            ),
            SizedBox(width: 10),
            Text('Olá Rhuan Silva!'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage('assets/doctors.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(12),
                child: Text(
                  'Os melhores médicos estão aqui',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  'Encontre tudo aqui com o aplicativo Saúde+',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Serviços:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildServiceItem(Icons.vaccines, 'Vacinas', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VacinasPage()),
                      );
                    }),
                    _buildServiceItem(Icons.biotech, 'Exames', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ExamesPage())
                      );
                    }),
                    _buildServiceItem(Icons.description, 'Documentos', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DocumentosPage())
                      );
                    }),
                    _buildServiceItem(Icons.local_hospital, 'Hospitais', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HospitaisPage())
                      );
                    }),
                    _buildServiceItem(Icons.medical_services, 'Consultas', () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const ConsultasPage())
                      );
                    }),
                    _buildServiceItem(Icons.local_pharmacy, 'Farmácias', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FarmaciasPage())
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.black12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Mais serviços'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(16),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}


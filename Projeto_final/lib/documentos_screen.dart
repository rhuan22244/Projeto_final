import 'package:flutter/material.dart';

class DocumentosPage extends StatefulWidget {
  const DocumentosPage({super.key});

  @override
  State<DocumentosPage> createState() => _DocumentosPageState();
}

class _DocumentosPageState extends State<DocumentosPage> {
  String categoriaSelecionada = 'Vacinas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.redAccent,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                const Text(
                  'DOCUMENTOS',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF3EDED),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Veja os seus documentos relacionados à área da saúde abaixo:',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCategoriaBotao(Icons.vaccines, 'Vacinas'),
                      _buildCategoriaBotao(Icons.medication, 'Medicamentos'),
                      _buildCategoriaBotao(Icons.description, 'Outros'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (categoriaSelecionada == 'Vacinas') _buildVacinasList(),
                  if (categoriaSelecionada == 'Medicamentos') _buildPlaceholder('Nenhum medicamento disponível.'),
                  if (categoriaSelecionada == 'Outros') _buildPlaceholder('Nenhum outro documento disponível.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriaBotao(IconData icon, String label) {
    final bool selecionado = categoriaSelecionada == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          categoriaSelecionada = label;
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: selecionado ? Colors.redAccent : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Icon(icon, color: selecionado ? Colors.white : Colors.black, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: selecionado ? Colors.redAccent : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVacinasList() {
    return Expanded(
      child: ListView(
        children: const [
          _VacinaCard(
            titulo: 'VACINA COVID 19 - SANTA LUZIA',
            dose: '1ª Dose',
            data: '14/10/2022',
            fabricante: 'Butantan',
          ),
          _VacinaCard(
            titulo: 'VACINA H1N1 - POSTO ARCO ÍRIS',
            dose: '1ª Dose',
            data: '09/11/2023',
            fabricante: 'FAPALAB',
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String texto) {
    return Expanded(
      child: Center(
        child: Text(
          texto,
          style: const TextStyle(color: Colors.black45, fontSize: 16),
        ),
      ),
    );
  }
}

class _VacinaCard extends StatelessWidget {
  final String titulo;
  final String dose;
  final String data;
  final String fabricante;

  const _VacinaCard({
    required this.titulo,
    required this.dose,
    required this.data,
    required this.fabricante,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  children: [
                    Text(dose, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Text(data, style: const TextStyle(fontSize: 11)),
                    Text(fabricante, style: const TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

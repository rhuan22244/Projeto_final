import 'package:flutter/material.dart';
import 'Consulta.dart';

class MarcarConsultaPage extends StatefulWidget {
  final void Function(Consulta consulta) onConsultaMarcada;

  const MarcarConsultaPage({super.key, required this.onConsultaMarcada});

  @override
  _MarcarConsultaPageState createState() => _MarcarConsultaPageState();
}

class _MarcarConsultaPageState extends State<MarcarConsultaPage> {
  final TextEditingController _especialidadeController = TextEditingController();
  final TextEditingController _localController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Marcar Consulta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Campo para escolher especialidade
            TextField(
              controller: _especialidadeController,
              decoration: InputDecoration(
                hintText: 'Digite a especialidade',
                prefixIcon: const Icon(Icons.medical_services),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // Campo para escolher local
            TextField(
              controller: _localController,
              decoration: InputDecoration(
                hintText: 'Digite o local',
                prefixIcon: const Icon(Icons.location_on),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // Campo para escolher data
            TextField(
              controller: _dataController,
              decoration: InputDecoration(
                hintText: 'Digite a data (DD/MM/YYYY)',
                prefixIcon: const Icon(Icons.calendar_today),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // Campo para escolher hora
            TextField(
              controller: _horaController,
              decoration: InputDecoration(
                hintText: 'Digite a hora (HH:MM)',
                prefixIcon: const Icon(Icons.access_time),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                // Validação dos campos
                if (_especialidadeController.text.isEmpty ||
                    _localController.text.isEmpty ||
                    _dataController.text.isEmpty ||
                    _horaController.text.isEmpty) {
                  // Exibe uma mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Todos os campos devem ser preenchidos!')),
                  );
                  return; // Impede a ação se algum campo estiver vazio
                }

                // Cria o objeto Consulta com os dados inseridos
                final consulta = Consulta(
                  especialidade: _especialidadeController.text,
                  local: _localController.text,
                  data: _dataController.text,
                  hora: _horaController.text,
                  status: 'Agendada', // Defina o status como 'Agendada'
                  id: 0, // Defina o ID como 0, pois será gerado automaticamente no banco
                );

                // Chama a função para adicionar a consulta
                widget.onConsultaMarcada(consulta);

                // Exibe log para depuração
                print("Consulta criada: ${consulta.toMap()}");

                // Fecha a tela de marcação de consulta e retorna à tela anterior
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check),
              label: const Text('Confirmar Consulta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




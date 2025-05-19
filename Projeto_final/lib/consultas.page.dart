import 'package:flutter/material.dart';
import 'package:projeto_final/Consulta.dart' as consulta_model;
import 'package:projeto_final/database/database_helper.dart';
import 'MarcarConsultaPage.dart';
import 'editarConsultasPage.dart';

class ConsultasPage extends StatefulWidget {
  const ConsultasPage({super.key});

  @override
  _ConsultasPageState createState() => _ConsultasPageState();
}

class _ConsultasPageState extends State<ConsultasPage> {
  List<consulta_model.Consulta> consultasAgendadas = [];
  List<consulta_model.Consulta> consultasFiltradas = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadConsultas();
    _searchController.addListener(_filterConsultas);
  }

  Future<void> _loadConsultas() async {
    final consultas = await DatabaseHelper.instance.getConsultas();
    setState(() {
      consultasAgendadas = consultas.cast<consulta_model.Consulta>();
      consultasFiltradas = consultas.cast<consulta_model.Consulta>();
    });
  }

  void _filterConsultas() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      consultasFiltradas = consultasAgendadas
          .where((consulta) =>
      consulta.especialidade.toLowerCase().contains(query) ||
          consulta.local.toLowerCase().contains(query))
          .toList();
    });
  }

  void _adicionarConsulta(consulta_model.Consulta consulta) async {
    await DatabaseHelper.instance.insertConsulta(consulta);
    _loadConsultas();
  }

  void _removerConsulta(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Tem certeza que deseja excluir esta consulta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await DatabaseHelper.instance.deleteConsulta(id);
      _loadConsultas();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text('Consultas'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'AGENDADAS'),
              Tab(text: 'FINALIZADAS'),
              Tab(text: 'CANCELADAS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ConsultasAgendadasTab(
              consultasAgendadas: consultasFiltradas,
              onMarcarConsulta: _adicionarConsulta,
              loadConsultas: _loadConsultas,
              onRemoverConsulta: _removerConsulta,
              searchController: _searchController, // <-- corrigido
            ),
            const Center(child: Text('Finalizadas')),
            const Center(child: Text('Canceladas')),
          ],
        ),
      ),
    );
  }
}

class _ConsultasAgendadasTab extends StatelessWidget {
  final List<consulta_model.Consulta> consultasAgendadas;
  final void Function(consulta_model.Consulta) onMarcarConsulta;
  final Future<void> Function() loadConsultas;
  final void Function(int) onRemoverConsulta;
  final TextEditingController searchController;

  const _ConsultasAgendadasTab({
    required this.consultasAgendadas,
    required this.onMarcarConsulta,
    required this.loadConsultas,
    required this.onRemoverConsulta,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Pesquisar uma consulta específica...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: consultasAgendadas.isEmpty
                ? const Center(child: Text('Nenhuma consulta agendada'))
                : ListView.builder(
              itemCount: consultasAgendadas.length,
              itemBuilder: (context, index) {
                final consulta = consultasAgendadas[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditarConsultaPage(
                          id: consulta.id,
                          especialidade: consulta.especialidade,
                          local: consulta.local,
                          data: consulta.data,
                          hora: consulta.hora,
                          status: consulta.status,
                        ),
                      ),
                    ).then((_) => loadConsultas());
                  },
                  child: _ConsultaCard(
                    especialidade: consulta.especialidade,
                    local: consulta.local,
                    data: consulta.data,
                    hora: consulta.hora,
                    status: consulta.status,
                    onRemover: () => onRemoverConsulta(consulta.id),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MarcarConsultaPage(
                          onConsultaMarcada: (consulta) {
                            onMarcarConsulta(consulta as consulta_model.Consulta);
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Marcar Consulta'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConsultaCard extends StatelessWidget {
  final String especialidade;
  final String local;
  final String data;
  final String hora;
  final String status;
  final VoidCallback onRemover;

  const _ConsultaCard({
    required this.especialidade,
    required this.local,
    required this.data,
    required this.hora,
    required this.status,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    especialidade,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.more_vert),
              ],
            ),
            const SizedBox(height: 4),
            Text(local),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 4),
                Text(data),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 18),
                const SizedBox(width: 4),
                Text(hora),
                const Spacer(),
                Text(
                  '+$status',
                  style: const TextStyle(color: Colors.black54),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onRemover,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}















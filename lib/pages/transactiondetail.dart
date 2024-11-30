import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatefulWidget {
  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final List<Map<String, String>> transactions = [
    {
      'property': 'Luxury Villa',
      'date': '2024-11-01',
      'amount': '\$250,000',
    },
    {
      'property': 'Modern Apartment',
      'date': '2024-10-20',
      'amount': '\$1,500 (Rent)',
    },
    {
      'property': 'Office Space',
      'date': '2024-09-15',
      'amount': '\$75,000',
    },
  ];

  void _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Transaction deleted"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F7F7),
      appBar: AppBar(
        title: Text("Transaction History"),
        backgroundColor: Color(0xFF3F72AF),
      ),
      body: transactions.isEmpty
          ? Center(
              child: Text(
                "No transactions yet.",
                style: TextStyle(
                  color: Color(0xFF112D4E),
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Dismissible(
                  key: Key(transaction['property']! + index.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteTransaction(index);
                  },
                  child: GestureDetector(
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Delete Transaction?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _deleteTransaction(index);
                                },
                                child: Text("Delete"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Cancel"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      color: Color(0xFFDBE2EF),
                      child: ListTile(
                        leading: Icon(
                          Icons.receipt,
                          color: Color(0xFF112D4E),
                        ),
                        title: Text(
                          transaction['property']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF112D4E),
                          ),
                        ),
                        subtitle: Text(
                          "Date: ${transaction['date']}",
                          style: TextStyle(color: Color(0xFF112D4E)),
                        ),
                        trailing: Text(
                          transaction['amount']!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: const Color.fromARGB(255, 19, 18, 18)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

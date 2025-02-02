import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding and decoding JSON

class Advertiser extends StatefulWidget {
  final String userName;

  // ignore: use_super_parameters
  const Advertiser({Key? key, required this.userName}) : super(key: key);

  @override
  State<Advertiser> createState() => _AdvertiserState();
}

class _AdvertiserState extends State<Advertiser> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedChats = prefs.getString('advertiser_chats');
    if (savedChats != null) {
      setState(() {
        _messages = List<Map<String, dynamic>>.from(json.decode(savedChats));
      });
    }
  }

  Future<void> _saveChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('advertiser_chats', json.encode(_messages));
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) {
      return; // Do nothing if input is empty
    }

    setState(() {
      _messages.add({
        'message': _messageController.text.trim(),
        'isSentByMe': true,
      });
    });

    _saveChats(); // Save chats after sending

    // Clear the input field after sending
    _messageController.clear();

    // Simulate a reply (for demo purposes)
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'message': 'Hello, How are you.',
          'isSentByMe': false,
        });
      });
      _saveChats(); // Save chats after receiving a reply
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Chat Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message['isSentByMe']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ChatBubble(
                    message: message['message'],
                    isSentByMe: message['isSentByMe'],
                  ),
                );
              },
            ),
          ),

          // Message Input and Send Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(LucideIcons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose(); // Clean up the controller
    super.dispose();
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatBubble({Key? key, required this.message, required this.isSentByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSentByMe ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(isSentByMe ? 20 : 0),
          bottomRight: Radius.circular(isSentByMe ? 0 : 20),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isSentByMe ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

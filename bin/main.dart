// For creating the bot.
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';

// For the command system.
import 'package:Telegram/Commands.dart';

void main() {
  TeleDart teledart = new TeleDart(new Telegram('YOUR-BOT-TOKEN'), new Event());

  teledart.startFetching();

  // Register all the commands you need.
  new Commands('/', teledart).addMany([new Start(), new Short()]);
}

class Short extends Command {
  Short() : super("short", "Tests the bot", "/start");

  @override
  run( Message message, TeleDart client ){
        client.replyPhoto(
            message,
            'https://raw.githubusercontent.com/DinoLeung/TeleDart/master/example/dart_bird_catchs_telegram.png',
            caption: 'This is how the Dart Bird and Telegram are met'
        );
  }
}

class Start extends Command {
  Start() : super("start", "Tests the bot", "/short");

  @override
  run( Message message, TeleDart client ){
    client.replyMessage(message,"Welcome, use /help to know more of my commands");
  }
}
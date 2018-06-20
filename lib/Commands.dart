import "package:log/log.dart";
export "Command/Command.dart";

/// The main command handler
class Commands {

	/// List of commands used.
	List<Command> _commands;

	/// List of admins of the group?
	List<String> _admins;

	/// The teledart instance
	TeleDart _client;


	// Make it according to your own project.
	Commands(this._client, [this._admins]){
		// Well, no use of admins for now.
		_commands = [];
		_client.onCommand('help').listen((message)=> _client.replyMessage( message, _createHelp() ) );
		Log.success("Added new command: /help");
	}

	/// Creates help String based on registred commands metadata.
	String _createHelp() {
		var buffer = new StringBuffer();

		buffer.writeln("\n**Available commands:**");

		_commands.forEach((item) {
			buffer.writeln("* ${item.name} - ${item.help}");
			buffer.writeln("\t Usage: ${item.usage}");
		});

		return buffer.toString();
	}

	/// Register new [Command] object
	void add(Command cmd){
		_commands.add(cmd);
		_client.onCommand(cmd.name).listen((msg) => cmd.run(msg, _client));
		Log.success("Added a new command: /${cmd.name}");
	}

	/// Register an array of [Command] objects
	void addMany(List<ICommand> commands){
		commands.forEach( (c) => add(c) );
	}

}
int main (string[] argv) {
    // Create a new application
    var app = new Gtk.Application ("com.elagost.alephone-launcher",
                                   GLib.ApplicationFlags.FLAGS_NONE);

    app.activate.connect (() => {
		var release="20220115";
        string command_out="";
        string command_err="";
        int command_status=0;

        var main_window = new Gtk.ApplicationWindow (app);
        main_window.default_height = 200;
        main_window.default_width = 300;
        main_window.title = "Marathon Launcher";

        var box = new Gtk.Box (Gtk.Orientation.VERTICAL,0);
		var image = new Gtk.Image ();
		var imgfile = File.new_for_path ("/usr/share/icons/hicolor/128x128/apps/marathon_128.png");
    	if (imgfile.query_exists ()) {
			image = new Gtk.Image.from_file  ("/usr/share/icons/hicolor/128x128/apps/marathon_128.png");
    	}
		else {
			image = new Gtk.Image.from_file ("marathon_128.png");
		}

		image.set_pixel_size(128);
        main_window.set_child (box);
        box.append (image);
        
        var textZone = new Gtk.Label ("");
        var button_test = new Gtk.Button.with_label ("Download/Play Marathon");
        var button_0 = new Gtk.Button.with_label ("Download Files (~100MB)");

		string gamedir=".local/share/AlephOne/";
		var home_dir=File.new_for_path(Environment.get_home_dir());
		var gamedir_f=home_dir.get_child(".local").get_child("share").get_child("AlephOne");
		gamedir_f.make_directory();
		
		// the first button
		button_test.clicked.connect(() => {
			string url1="https://github.com/Aleph-One-Marathon/alephone/releases/download/release-"+release+"/Marathon-"+release+"-Data.zip";
			string zip1=".local/share/AlephOne/Marathon.zip";
			var filezip1=gamedir_f.get_child("Marathon.zip");
			var filedir1=gamedir_f.get_child("Marathon");
			var fileurl1= File.new_for_uri(url1);

			// if gamedata dir exists, run game
			if (filedir1.query_file_type(0) == FileType.DIRECTORY){
				try{
					Process.spawn_command_line_sync ("alephone "+dir1);
					textZone.label=command_out+"\n"+command_err+"\n";
					button_test.sensitive = true;
				}
				catch (SpawnError e) {
					textZone.label=e.message+"\n"+command_out+"\n";
					stdout.printf ("Error: %s\n", e.message);
				}
			}
			// if gamedata dir does not exist, but file does
			else if (filezip1.query_exists()) {
				try{
					Process.spawn_command_line_sync ("unzip "+zip1+" -d "+gamedir);
					textZone.label=command_out+"\n"+command_err+"\n";
					button_test.sensitive = true;
				}
				catch (SpawnError e) {
					textZone.label=e.message+"\n"+command_out+"\n";
					stdout.printf ("Error: %s\n", e.message);
				}
			}
			else {
				string cmd="wget "+url1+" -O "+zip1;
				try{
					Process.spawn_command_line_sync (cmd);
					Process.spawn_command_line_sync ("unzip "+zip1+" -d "+gamedir);
					textZone.label=command_out+"\n"+command_err+"\n";
					button_test.label="Downloaded! Click to play.";
					button_test.sensitive = true;
				}
				catch (SpawnError e) {
					textZone.label=e.message+"\n"+command_out+"\n";
					stdout.printf ("Error: %s\n", e.message);
				}
			}

		});

		//
		// these are the old buttons!
		//
		button_0.clicked.connect (() => {
		    button_0.label = "Downloading game files - launcher may freeze";
		    button_0.sensitive = false;
		    try{
				Process.spawn_command_line_sync ("sh -c \"exec marathon-installer.sh\"", out command_out, out command_err, out command_status);
				textZone.label=command_out+"\n"+command_err+"\n";
			    button_0.sensitive = true;
			}
			catch (SpawnError e) {
				textZone.label=e.message+"\n"+command_out+"\n";
				stdout.printf ("Error: %s\n", e.message);
			}
		    button_0.label = "Download complete.";
		});

        var button_1 = new Gtk.Button.with_label ("Marathon");
		button_1.clicked.connect (() => {
		    try{
				Process.spawn_command_line_sync ("sh -c \"alephone ~/.local/share/marathon/Marathon\"", out command_out);
			}
			catch (SpawnError e) {
				stdout.printf ("Error: %s\n", e.message);
			}
		});

		var button_2 = new Gtk.Button.with_label ("Marathon 2");
		button_2.clicked.connect (() => {
		    try{
				Process.spawn_command_line_sync ("sh -c \"alephone ~/.local/share/marathon/Marathon2\"", out command_out);
			}
			catch (SpawnError e) {
				stdout.printf ("Error: %s\n", e.message);
			}
		});

		var button_3 = new Gtk.Button.with_label ("Marathon Infinity");
		button_3.clicked.connect (() => {
		    try{
				Process.spawn_command_line_sync ("sh -c \"alephone ~/.local/share/marathon/MarathonInfinity\"", out command_out);
			}
			catch (SpawnError e) {
				stdout.printf ("Error: %s\n", e.message);
			}
		});
		
		//construct the box!
		box.append (button_test);
		box.append (button_0);
		box.append (button_1);
		box.append (button_2);
		box.append (button_3);
		box.append (textZone);
        main_window.present ();
    });
    return app.run (argv);
}

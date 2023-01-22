int main (string[] argv) {
    // Create a new application
    var app = new Gtk.Application ("com.elagost.alephone-launcher",
                                   GLib.ApplicationFlags.SEND_ENVIRONMENT);

    app.activate.connect (() => {

		var release="20230119";
        string command_out="";
        string command_err="";

        var main_window = new Gtk.ApplicationWindow (app);
        main_window.default_height = 200;
        main_window.default_width = 300;
        main_window.title = "Marathon Launcher";

        var box = new Gtk.Box (Gtk.Orientation.VERTICAL,0);

		// use local image if installed image doesn't exist
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
        var upstreamLink = new Gtk.LinkButton.with_label ("https://alephone.lhowon.org/","Aleph One Project");
        var srcLink = new Gtk.LinkButton.with_label ("https://git.sr.ht/~elagost/alephone-launcher","Launcher Source");
        var textZone = new Gtk.Label ("");
        
		// create the buttons, initially say "not downloaded"
		var m1status="(Not Downloaded)";
		var m2status="(Not Downloaded)";
		var m3status="(Not Downloaded)";
        var button_m1 = new Gtk.Button.with_label ("Marathon "+m1status);
        var button_m2 = new Gtk.Button.with_label ("Marathon 2 "+m2status);
        var button_m3 = new Gtk.Button.with_label ("Marathon Infinity "+m3status);

		// create ~/.local/share/AlephOne
		var home_dir=File.new_for_path(Environment.get_home_dir());
		var gamedir=home_dir.get_child(".local").get_child("share").get_child("AlephOne");
		if ( gamedir.query_file_type(0) != FileType.DIRECTORY ){
			try {
				gamedir.make_directory();
			}
			catch (Error e) {
				stdout.printf ("Error: %s\n", e.message);
			}
		}

		// this is where to download the game files
		string urls[]={
			"https://github.com/Aleph-One-Marathon/alephone/releases/download/release-"+release+"/Marathon-"+release+"-Data.zip",
			"https://github.com/Aleph-One-Marathon/alephone/releases/download/release-"+release+"/Marathon2-"+release+"-Data.zip",
			"https://github.com/Aleph-One-Marathon/alephone/releases/download/release-"+release+"/MarathonInfinity-"+release+"-Data.zip"
		};


		string gameTitles[]={"Marathon","Marathon 2","Marathon Infinity"};
		string zipTitles[]={"Marathon.zip","Marathon2.zip","MarathonInfinity.zip"};
		Array<Gtk.Button> mbtns = new Array<Gtk.Button> ();
		mbtns.append_val(button_m1);
		mbtns.append_val(button_m2);
		mbtns.append_val(button_m3);

		// loop 3 times, construct button and add connection event
		for (var i=0;i<3;i++){
			var mydir=gamedir.get_child(gameTitles[i]);
			string myurl=urls[i];
			string zipFullPath=gamedir.get_path()+"/"+zipTitles[i];
			string wcmd="wget "+myurl+" -O "+zipFullPath;
			string zcmd="unzip "+zipFullPath+" -d "+gamedir.get_path();

			// if the game directory exists, set button title to playable
			if (mydir.query_file_type(0) == FileType.DIRECTORY){
				mbtns.index(i).label=gameTitles[i]+" - Play";
			}
			mbtns.index(i).clicked.connect(() => {
				var mbtn=mbtns.index(i);
				// if the game data exists, play
				if (mydir.query_file_type(0) == FileType.DIRECTORY){
					try{
						Process.spawn_command_line_sync ("alephone '"+mydir.get_path()+"'");
						textZone.label=command_out+"\n"+command_err+"\n";
						mbtns.index(i).sensitive = true;
					}
					catch (SpawnError e) {
						textZone.label=e.message+"\n"+command_out+"\n";
						stdout.printf ("Error: %s\n", e.message);
					}
				}
				// otherwise, download and extract
				else {
					stdout.printf("\n%s\n",zipFullPath);
					stdout.printf("\n%s\n%s\n",wcmd,zcmd);
					try{
						// need to figure out how to download stuff with glib
						// spawn a wget command, then an unzip command
						Process.spawn_command_line_sync (wcmd);
						Process.spawn_command_line_sync (zcmd);
						textZone.label=command_out+"\n"+command_err+"\n";
						mbtn.sensitive = true;
					}
					catch (SpawnError e) {
						textZone.label=e.message+"\n"+command_out+"\n";
						stdout.printf ("Error: %s\n", e.message);
					}
					mbtn.label=gameTitles[i]+" - Play";
				}

			});

		}
		
		//construct the box!
		box.append (upstreamLink);
		box.append (srcLink);
		box.append (button_m1);
		box.append (button_m2);
		box.append (button_m3);
		box.append (textZone);
        main_window.present ();
    });
    return app.run (argv);
}

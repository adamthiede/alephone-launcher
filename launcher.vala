public class Launcher : Gtk.Application {

    public Launcher () {
        Object (
            application_id: "com.gitlab.elagost.alephone-marathon-installer",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 200;
        main_window.default_width = 300;
        main_window.title = "Marathon Launcher";
        main_window.border_width=10;
        main_window.window_position=Gtk.WindowPosition.CENTER;
        main_window.destroy.connect (Gtk.main_quit);
        var box = new Gtk.Box (Gtk.Orientation.VERTICAL,0);
		//if you're just running it from the build dir, uncomment line 21 otherwise the icon won't show.
		var image = new Gtk.Image.from_file ("/usr/share/icons/hicolor/128x128/apps/marathon_128.png");
		image = new Gtk.Image.from_file ("marathon_128.png");
        main_window.add (box);
        box.add (image);
        string command_out="";
        string command_err="";
        int command_status=0;
        
        var textZone = new Gtk.Label ("");
		textZone.margin = 1;

        var button_0 = new Gtk.Button.with_label ("Download Files (~100MB)");

/*
        var dir1s="~/.local/share/marathon/Marathon/";
        var dir2s="~/.local/share/marathon/Marathon2/";
        var dir3s="~/.local/share/marathon/MarathonInfinity/";

        if (GLib.Path.get_dirname) {
            button_0.label =  ("Download Files (~100MB) (already downloaded)");
        }
        */

		button_0.margin = 1;
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
		button_1.margin = 1;
		button_1.clicked.connect (() => {
		    try{
				Process.spawn_command_line_sync ("sh -c \"alephone ~/.local/share/marathon/Marathon\"", out command_out);
			}
			catch (SpawnError e) {
				stdout.printf ("Error: %s\n", e.message);
			}
		});

		var button_2 = new Gtk.Button.with_label ("Marathon 2");
		button_2.margin = 1;
		button_2.clicked.connect (() => {
		    try{
				Process.spawn_command_line_sync ("sh -c \"alephone ~/.local/share/marathon/Marathon2\"", out command_out);
			}
			catch (SpawnError e) {
				stdout.printf ("Error: %s\n", e.message);
			}
		});

		var button_3 = new Gtk.Button.with_label ("Marathon Infinity");
		button_3.margin = 1;
		button_3.clicked.connect (() => {
		    try{
				Process.spawn_command_line_sync ("sh -c \"alephone ~/.local/share/marathon/MarathonInfinity\"", out command_out);
			}
			catch (SpawnError e) {
				stdout.printf ("Error: %s\n", e.message);
			}
		});
		
		//construct the box!
		box.add (button_0);
		box.add (button_1);
		box.add (button_2);
		box.add (button_3);
		box.add (textZone);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new Launcher ();
        return app.run (args);
    }
}

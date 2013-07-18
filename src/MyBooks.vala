// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2013 Diego Toral
 *
 * This software is licensed under the GNU General Public License
 * (version 3 or later). See the COPYING file in this distribution.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this software; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Authored by: Diego Toral <diegotoral@gmail.com>
 */

 namespace MyBooks {
    public class MyBooks : Granite.Application {

        private Gtk.Toolbar toolbar;
        private Gtk.Box main_container;
        private Gtk.ApplicationWindow window;
        private Granite.Widgets.ThinPaned paned;

        construct {
            program_name = "MyBooks";
            exec_name = "mybooks";

            build_data_dir = Constants.DATADIR;
            build_pkg_data_dir = Constants.PKGDATADIR;
            build_version = Constants.VERSION;

            app_years = "2013";
            app_icon = "applications-chat";
            app_launcher = "mybooks.desktop";
            application_id = "org.mybooks";

            main_url = "https://github.com/diegotoral/SeasonHunter";
            bug_url = "https://github.com/diegotoral/SeasonHunter/issues";
            help_url = "https://github.com/diegotoral/SeasonHunter/wiki";
            translate_url = "https://github.com/diegotoral/SeasonHunter";

            about_authors = {"Diego Toral <diegotoral@gmail.com>"};
            about_documenters = {"Diego Toral <diegotoral@gmail.com>"};
            about_artists = {""};
            about_comments = "Development release, not all features implemented";
            about_translators = "";
            about_license_type = Gtk.License.GPL_3_0;
        }

        public override void activate ()
        {
            if (get_windows () == null)
            {
                // Window
                window = new Gtk.ApplicationWindow (this);
                window.title = "MyBooks";
                window.width_request = 1100;
                window.height_request = 600;
                window.window_position = Gtk.WindowPosition.CENTER;

                // Main container
                main_container = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

                // Toolbar
                toolbar = new Gtk.Toolbar ();

                // Paned
                paned = new Granite.Widgets.ThinPaned ();
                paned.set_position (300);

                main_container.pack_start (toolbar, false);
                main_container.pack_end (paned, true);

                window.add (main_container);

                window.show_all ();
            }
        }

        public static int main (string[] args)
        {
            Gtk.init (ref args);
            var app = new MyBooks ();

            return app.run (args);
        }
    }
 }
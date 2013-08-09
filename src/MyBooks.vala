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
        private Library library;

        private Gtk.Box main_container;
        private Widgets.Toolbar toolbar;
        private Widgets.SideBar sidebar;
        private Widgets.StatusBar statusbar;
        private Gtk.ApplicationWindow window;
        private Granite.Widgets.ThinPaned paned;
        private Granite.Widgets.Welcome welcome;

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

        public MyBooks ()
        {
            DEBUG = true;
        }

        public override void activate ()
        {
            if (get_windows () == null)
            {
                // Initialize the interface elements
                init_library ();
                init_toolbar ();
                init_window ();

                show_welcome ();

                window.show_all ();
            }
        }

        private void init_window ()
        {
            // Window
            window = new Gtk.ApplicationWindow (this);
            window.title = "MyBooks";
            window.width_request = 1100;
            window.height_request = 600;
            window.window_position = Gtk.WindowPosition.CENTER;

            // Main container
            main_container = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            // Paned
            paned = new Granite.Widgets.ThinPaned ();
            paned.set_position (200);

            // Sidebar
            statusbar = new Widgets.StatusBar ();
            sidebar = new Widgets.SideBar (library.categories);

            paned.add1 (sidebar);
            main_container.pack_start (toolbar, false);
            main_container.pack_start (paned, true);
            main_container.pack_end (statusbar, false);

            window.add (main_container);
        }

        private void init_toolbar ()
        {
            var menu = new Gtk.Menu ();
            toolbar = new Widgets.Toolbar (menu, create_appmenu (menu));
        }

        private void init_library ()
        {
            var categories = Library.default_categories ();
            var books = new Gtk.ListStore (3, typeof (string), typeof (string), typeof (string));

            // Load the library
            library = new Library (books, categories);
        }

        private void show_welcome ()
        {
            welcome = new Granite.Widgets.Welcome (
                _("Your library is empty"),
                _("Select a directory and good reading")
            );

            welcome.append (
                Gtk.Stock.OPEN,
                _("Load a directory"),
                _("Load books from a directory and add to your collection")
            );

            welcome.activated.connect ((index) => {
                var dialog = new Gtk.FileChooserDialog (
                    _("Select a directory to load files from"),
                    this.window, Gtk.FileChooserAction.SELECT_FOLDER,
                    Gtk.Stock.CANCEL, Gtk.ResponseType.CANCEL,
                    Gtk.Stock.OPEN, Gtk.ResponseType.ACCEPT,
                    null
                );

                if (dialog.run () == Gtk.ResponseType.ACCEPT)
                {
                    library.load_from_directory (dialog.get_file ());
                    toolbar.set_disabled (false);

                    var scrolled = new Gtk.ScrolledWindow (null, null);
                    var books_list = new Widgets.BooksListView (library.books);

                    paned.remove (welcome);
                    scrolled.add (books_list);
                    paned.add2 (scrolled);

                    scrolled.show_all ();
                }

                dialog.destroy ();
            });

            paned.add2 (welcome);
        }

        public static int main (string[] args)
        {
            Gtk.init (ref args);
            var app = new MyBooks ();

            return app.run (args);
        }
    }
 }

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

 namespace Books {
    public class BooksApp : Granite.Application {
        private Library library;

        private Gtk.Box main_container;
        private Widgets.Toolbar toolbar;
        private Widgets.SideBar sidebar;
        private Widgets.StatusBar statusbar;
        private Gtk.ApplicationWindow window;
        private Gtk.Paned paned;
        private Granite.Widgets.Welcome welcome;

        construct {
            program_name = "Books";
            exec_name = "books";

            build_data_dir = Constants.DATADIR;
            build_pkg_data_dir = Constants.PKGDATADIR;
            build_version = Constants.VERSION;

            app_years = "2013";
            app_icon = "applications-chat";
            app_launcher = "books.desktop";
            application_id = "org.books";

            main_url = "https://github.com/diegotoral/Books";
            bug_url = "https://github.com/diegotoral/Books/issues";
            help_url = "https://github.com/diegotoral/Books/wiki";
            translate_url = "https://github.com/diegotoral/Books";

            about_authors = {"Diego Toral <diegotoral@gmail.com>"};
            about_documenters = {"Diego Toral <diegotoral@gmail.com>"};
            about_artists = {""};
            about_comments = "Development release, not all features implemented";
            about_translators = "";
            about_license_type = Gtk.License.GPL_3_0;
        }

        public BooksApp ()
        {
            DEBUG = debug;
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
            window.title = "Books";
            window.width_request = 1100;
            window.height_request = 600;
            window.window_position = Gtk.WindowPosition.CENTER;

            // Main container
            main_container = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            // Paned
            paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
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

        // Context options
        static bool version = false;
        static bool refresh_database = false;
        static bool debug = false;

        const OptionEntry[] entries = {
            { "version", 0, 0, OptionArg.NONE, ref version, N_("Display version number"), null },
            { "debug", 0, 0, OptionArg.NONE, ref debug, N_("Show debug messages"), null },
            { "refresh-database", 'r', 0, OptionArg.NONE, ref refresh_database, N_("Recreates database files"), null },
            { null }
        };

        public static int main (string[] args)
        {
            var context = new OptionContext ("");
            context.add_main_entries (entries, Constants.GETTEXT_PACKAGE);

            try {
                context.parse (ref args);
            }
            catch(Error e) {
                warning (e.message);
            }

            // Handle context options
            if (version)
            {
                print ("%s\n", Constants.VERSION);

                return 0;
            }

            var app = new BooksApp ();

            return app.run (args);
        }
    }
 }

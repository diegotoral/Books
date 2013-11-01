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
    public class Library : Object {
        public int total_books = 0;

        public Gtk.ListStore books;
        public Gtk.TreeStore categories;

        public Library (Gtk.ListStore books, Gtk.TreeStore categories, int total_books = 0)
        {
            this.books = books;
            this.categories = categories;
            this.total_books = total_books;
        }

        public void load_from_directory (File directory)
        {
            assert (directory != null);

            debug ("Loading books from " + directory.get_path ());

            try
            {
                var infos = directory.enumerate_children (
                    "standard::name,standard::type,standard::content-type,standard::size",
                    FileQueryInfoFlags.NOFOLLOW_SYMLINKS, null
                );

                var file = infos.next_file ();

                while (file != null)
                {
                    var type = file.get_file_type ();

                    if (type == FileType.DIRECTORY)
                        this.load_from_directory (directory.get_child (file.get_name ()));
                    else
                    {
                        var size = file.get_size ();
                        var content_type = file.get_content_type ();

                        if (content_type == "application/pdf")
                            insert_book (file.get_name (), "path", size.to_string ());
                    }

                    file = infos.next_file ();
                }
            }
            catch(GLib.Error er)
            {
                error(_("Error while loading files from directory %s.\nMessage: %s"), directory.get_path (), er.message);
            }
        }

        public void insert_category (string name)
        {
            Gtk.TreeIter iter;

            categories.append (out iter, null);
            categories.set (iter, 0, name, -1);
        }

        public void insert_book (string title, string path, string size)
        {
            Gtk.TreeIter iter;

            total_books++;

            books.append (out iter);
            books.set (iter, 0, title, 1, path, 2, size, -1);
        }

        public static Gtk.TreeStore default_categories ()
        {
            Gtk.TreeStore categories;
            Gtk.TreeIter library, all;

            categories = new Gtk.TreeStore (1, typeof (string));

            categories.append (out library, null);
            categories.set (library, 0, _("Library"), -1);

            categories.append (out all, library);
            categories.set (all, 0, _("All books"), -1);

            return categories;
        }
    }
 }

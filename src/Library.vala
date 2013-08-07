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
    public class Library : Object {
        public Gtk.TreeStore books;
        public Gtk.TreeStore categories;

        public Library (Gtk.TreeStore books, Gtk.TreeStore categories)
        {
            this.books = books;
            this.categories = categories;
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

            books.append (out iter, null);
            books.set (iter, 0, title, path, size, -1);
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

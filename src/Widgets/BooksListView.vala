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

 namespace Books.Widgets {
    public class BooksListView : Gtk.TreeView {

        public BooksListView (Gtk.ListStore books)
        {
            set_model (books);
            set_headers_visible (true);
            set_headers_clickable (true);
            // set_grid_lines(Gtk.TreeViewGridLines.NONE);

            configure_columns ();
        }

        private void configure_columns ()
        {
            insert_column_with_attributes (0, _("Title"), new Gtk.CellRendererText (), "text", 0, null);
            insert_column_with_attributes (1, _("Path"), new Gtk.CellRendererText (), "text", 1, null);
            insert_column_with_attributes (2, _("Size"), new Gtk.CellRendererText (), "text", 2, null);
        }
    }
 }

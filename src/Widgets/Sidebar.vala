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
    public class SideBar : Gtk.TreeView {
        public Gtk.TreeStore categories;

        public SideBar (Gtk.TreeStore categories)
        {
            this.categories = categories;

            set_model (this.categories);
            set_headers_visible (false);
            set_fixed_height_mode (true);
            // set_show_expanders (false);
            set_grid_lines(Gtk.TreeViewGridLines.NONE);
            get_style_context ().add_class (Gtk.STYLE_CLASS_SIDEBAR);

            configure_columns ();
            expand_all ();
        }

        private void configure_columns ()
        {
            insert_column_with_attributes (-1, "visible", new Gtk.CellRendererText (), "text", 0, null);
        }
    }
 }

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
    public class Toolbar : Gtk.Toolbar {
        private Gtk.Menu menu;

        private Granite.Widgets.AppMenu appmenu;
        private Granite.Widgets.SearchBar search_field;

        public Toolbar (Gtk.Menu menu, Granite.Widgets.AppMenu appmenu, bool disabled = true)
        {
            this.menu = menu;
            this.appmenu = appmenu;

            get_style_context ().add_class (Gtk.STYLE_CLASS_PRIMARY_TOOLBAR);

            init_menu ();
            init_items ();

            set_disabled (disabled);

            add (appmenu);
        }

        private void init_menu ()
        {
            // Import item
            var import = new Gtk.MenuItem.with_label (_("Import books"));
            this.menu.prepend (import);

            // Preferences item
            var preferences = new Gtk.MenuItem.with_label (_("Preferences"));
            this.menu.prepend (preferences);
        }

        private void init_items ()
        {
            var search_field_item  = new Gtk.ToolItem ();

            // SearchBar
            search_field = new Granite.Widgets.SearchBar(_("Search books"));
            search_field_item.add (search_field);

            add_spacer ();
            add (search_field_item);
        }

        public void set_disabled (bool disabled)
        {
            search_field.set_sensitive (!disabled);
        }

        private void add_spacer ()
        {
            var spacer = new Gtk.ToolItem ();
            spacer.set_expand (true);
            add (spacer);
        }
    }
 }

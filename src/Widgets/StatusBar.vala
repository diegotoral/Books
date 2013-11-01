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
    public class StatusBar : Granite.Widgets.StatusBar {
        public Gtk.Label total_books_label { get; private set; default = new Gtk.Label ("Library empty"); }

        public StatusBar (int total_books = 0)
        {
            total_books_label.set_text ((string) total_books);

            insert_widget (new Gtk.Button.with_label("Teste"), true);
            insert_widget (total_books_label, true);
        }
    }
 }

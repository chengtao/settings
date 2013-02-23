# ~/Library/Application Support/Sublime Text 2/Packages/User/sort_by_column.py
import sublime
import sublime_plugin

# Don't want a global but the sort key won't take colkey as a parameter
colkey = -1


def colsort(item):
    global colkey

    # Special case where the item is a blank line in otherwise normal col data
    if len(item) < colkey + 1:
        return float("inf")
    return item[colkey]


class SortLinesColumnCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        global colkey

        for selection in self.view.sel():
            if(selection == None):
                continue

            # get region of word under cursor and that line
            wordselection = self.view.word(selection.end())
            last_line_sel = self.view.line(selection.end())

            # Get str of the beginning of last line up to cursor
            line_start = self.view.substr(sublime.Region(last_line_sel.begin(),
                    wordselection.end()))
            # column that the end cursor is positioned at
            colkey = len(line_start.split(" ")) - 1

            # position of the start of the line at the beginning of selection
            startp = self.view.line(selection.begin()).begin()

            # create array of all lines in the selection region
            sortarray = []
            for linesel in self.view.lines(selection):
                sortarray.append(self.view.substr(linesel).split(' '))

            # erase the lines from the window so we can place in proper order
            for linesel in reversed(self.view.lines(selection)):
                self.view.erase(edit, self.view.full_line(linesel))

            # sort then append the list together as a single string with \n
            sortarray.sort(key=colsort)
            sorted_str = ""
            for line in sortarray:
                sorted_str += " ".join(line) + "\n"  # Need space between cols

            # paste the sorted string onto the window
            self.view.insert(edit, startp,  sorted_str)

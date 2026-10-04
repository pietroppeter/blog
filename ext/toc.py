##
# This extension adds a table of contents (index) at the top of a page
# a node gets a toc if it has a toc metadata (set to true)
# the toc lists the h2, h3 and h4 headings of the page, nested by level
# headings get their id from the markdown toc extension (see markdown_settings in config.py)
# the title of the toc can be set with toc_title in config.py
import html
import re

import ark


heading_re = re.compile(r'<h([2-4])[^>]*\bid="([^"]+)"[^>]*>(.*?)</h\1>', re.DOTALL)
tag_re = re.compile(r'<[^>]+>')


@ark.filters.register(ark.filters.Filter.NODE_HTML)
def add_toc(node_html, node):
    if not node.get("toc"):
        return node_html
    headings = [
        (int(level), id_, tag_re.sub("", text).strip())
        for level, id_, text in heading_re.findall(node_html)
    ]
    if not headings:
        return node_html
    return make_toc(headings) + node_html


def make_toc(headings):
    title = ark.site.config.get("toc_title", "Contents")
    lines = ['<nav class="toc">', f"<p>{html.escape(title)}</p>"]
    base = min(level for level, _, _ in headings)
    depth = base - 1
    for level, id_, text in headings:
        # never skip more than one level when going deeper
        level = min(level, depth + 1)
        if level > depth:
            lines.append("<ul>")
        else:
            lines.append("</li>")
            lines.extend(["</ul></li>"] * (depth - level))
        lines.append(f'<li><a href="#{id_}">{text}</a>')
        depth = level
    lines.append("</li>")
    lines.extend(["</ul></li>"] * (depth - base))
    lines.append("</ul>")
    lines.append("</nav>")
    return "\n".join(lines)

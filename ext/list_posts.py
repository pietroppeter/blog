##
# This extension automatically generates a list of posts sorted by date (reverse sort)
# each element of the list is a dict with entries title, date and node url
# the list is appended to page_data during rendering
# a node is added to the list if it has a is_post (set to true), title and date metadata
# the idea is to use this only when the page is a homepage to list all posts
#
# posts with draft: true are left out of the list, unless the page has list_drafts: true
# (see src/drafts/index.md), in which case only drafts are listed
#
# the implementation for this extension is derived from automenu bundled extension
import ark


# We generate the list once and cache it for future use.
cached_posts = None
cached_drafts = None


# Register a callback to add an 'posts' attribute to each page-data dictionary.
@ark.events.register(ark.events.Event.RENDER_PAGE)
def add_posts(page_data):
    global cached_posts, cached_drafts
    if cached_posts is None:
        cached_posts, cached_drafts = make_posts()
    if page_data['node'].meta.get("list_drafts"):
        page_data['posts'] = cached_drafts
    else:
        page_data['posts'] = cached_posts


def make_posts():
    root = ark.nodes.root()
    all_nodes = collect_all_nodes(root)
    posts = [
        dict(title=node.meta["title"], date=node.meta["date"], url=node.url, draft=node.meta.get("draft", False))
        for node in all_nodes
        if ("title" in node.meta) and ("date" in node.meta) and ("is_post" in node.meta) and (node.meta["is_post"])
    ]
    posts.sort(key=lambda p: p["date"], reverse=True)
    return [p for p in posts if not p["draft"]], [p for p in posts if p["draft"]]


def collect_all_nodes(root):
    if root is None:
        return []
    
    # Start by adding the root node itself
    nodes = [root]
    
    # Recursively collect all nodes from the children
    for child in root.children:
        nodes.extend(collect_all_nodes(child))
    
    return nodes

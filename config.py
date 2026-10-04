# ------------------------- #
#  Site Configuration File  #
# ------------------------- #

# Variables set here will be available in template files under a `site` attribute,
# e.g. {{ site.title }}.

# Choose the theme to use when building your site. This variable should specify
# the name of a theme directory in your site's 'lib' folder.
theme = "ihwd" # I ❤️ web design

# Site title.
title = "pietroppeter's personal blog"

# Site tagline.
tagline = "recursing"

lib_dir = "themes"
out_dir = "docs"
res_dir = "resources"

# adds in head the et_font
use_et_font = False

# Markdown settings: the `toc` extension adds an `id` to every heading,
# which the `ext/toc.py` extension uses to build a table of contents.
markdown_settings = {"extensions": ["toc"]}

# Title of the table of contents shown in posts with `toc: true`.
toc_title = "Contents"

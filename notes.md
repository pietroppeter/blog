## 2024-09-14

during [![Open Source Saturday](https://img.shields.io/badge/%E2%9D%A4%EF%B8%8F-open%20source%20saturday-F64060.svg)](https://www.meetup.com/it-IT/Open-Source-Saturday-Milano/)

- clean up blog.egg-info folder (who added it?) [x]
- exclude et_font css in head [x]
  - how do I exclude the asset? how do I exclude a directory in src? or a path, conditionally?
- learning ark
  - use a head template? yes, since I will need to include in two types of template (home and post)
- plan what to change in order to list posts!
  - check how the blog theme does it
    - here is a blog theme: https://github.com/dmulholl/twentyfifteen
    - which is based on this blog plugin: https://github.com/dmulholl/holly
    - mmh, I do not want to use a plugin (and I do not think I need it, do I?)
    - mmh, maybe I need it! it seems I cannot 
- minimal nav between posts (aka home) and about page [x]
  - how to style it? I need a class but I cannot have a class from md
  - change nav.md to nav.html and styled with minimal styling [x]

## 2024-09-07

- setup with uv [x]

## 2023-10-30

### leftover for next post

- [ ] use a blog theme (posts)
- [ ] deploy with CI
- [ ] style code snippets

### ihwd theme + post recursing0

- content0: content written in Toceno (minus schedule)
- ihwd0: center text and limit width
- content1: fix text and links. fix wording of rules
- colors, spacing and that's about it
- [x] ah the date!
  - I was not able to do it with the theme
- [ ] et-font? no later

# learning ark

- issue: site.py clashes with PyLance :/ (can change to config.py!)
- lib is ignored but maybe it shouldn't? unignored partially (and changed to themes)
- should I remove the menu in inc? done
- should I rename out to docs? done

### setup


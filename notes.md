## ihwd theme + post recursing0

- content0: content written in Toceno (minus schedule)
- ihwd0: center text and limit width
- content1: fix text and links. fix wording of rules

## on ark

- issue: site.py clashes with PyLance :/
- lib is ignored but maybe it shouldn't? unignored partially
- should I remove the menu in inc? done
- should I rename out to docs?

## setup

- creating a virtual environment with venv:
  - `python3 -m venv env`
  - (note that python3 and python on my system are both python but different versions)
- ignore from https://github.com/github/gitignore/blob/main/Python.gitignore
- activate with source env/bin/activate
- install ark with `python -m pip install ark`
- (deactivate with deactivate)


```
base   12:01:10  
❯ python3 --version           
Python 3.11.1

    ~/blog    main ───────── base   12:01:58  
❯ python3 -m venv env

    ~/blog    main ?1 ─
    ~/blog    main ?1 
❯ which python
/usr/local/bin/python

    ~/blog    main ?2 
❯ which python3
/Library/Frameworks/Python.framework/Versions/3.11/bin/python3

    ~/blog    main ?2 
❯ which python   
/usr/local/bin/python

    ~/blog    main ?2 
❯ python --version   
Python 3.9.18

    ~/blog    main ?2 
❯ which python3  
/Library/Frameworks/Python.framework/Versions/3.11/bin/python3

    ~/blog    main ?2 
❯ python3 --version  
Python 3.11.1

    ~/blog    main ?2 
❯ source env/bin/activate

    ~/blog    main ?2 
❯ which python 
/Users/pietroppeter/blog/env/bin/python

    ~/blog    main ?2 
❯ python --version 
Python 3.11.1

```
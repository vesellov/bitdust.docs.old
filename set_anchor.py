import os
import sys
import re

def _sub(m):
    print m.group(2)
    # return m.group(0)
    return '<a class=hlnk id="%s"></a>\n%s %s' % (
            m.group(2).replace(' ','-'), m.group(1), m.group(2))

for fn in os.listdir('.'):
    if not fn.endswith('.md'):
        continue
        
    print fn
    src = open(fn, 'rb').read()
    open(fn, 'wb').write(re.sub("([\#]{1,6})\ (.+)", _sub, src))


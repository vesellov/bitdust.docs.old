import os
import sys
import re

def _sub(m):
    print m.group(1), m.group(2)
    return "%s%s" % ( m.group(1), m.group(2).lower().replace('.html#', '.md#') )

for fn in os.listdir('.'):
    if not fn.endswith('.md'):
        continue  
    print fn
    src = open(fn, 'rb').read()
    open(fn, 'wb').write(re.sub("(\[.+?\])(\(.+?\))", _sub, src))


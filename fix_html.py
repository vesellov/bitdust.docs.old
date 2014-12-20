import sys
import re
md_base = '../'
gitlab_base = 'http://gitlab.bitpie.net/devel/bitpie.devel/blob/master/'
template = open('html.template').read()
src = sys.argv[1]
dest = sys.argv[2]
styles = sys.argv[3]
sbody = open(src).read()
sbody = re.sub('a href="(.+?)\.md"', 'a href="%s\g<1>.html"' % md_base, sbody)
sbody = re.sub('a href="(.+?)\.py"', 'a href="%s\g<1>.py"' % gitlab_base, sbody)
sbody = re.sub('a href="../docs/(.+?)\.html"', 'a href="\g<1>.html"', sbody)
sbody = re.sub('a href="docs/(.+?)\.html"', 'a href="\g<1>.html"', sbody)
sbody = re.sub('\>\<img alt="', '><img width=1000 alt="', sbody) 
sbody = re.sub('a href="(\w+?)"', 'a href="\g<1>.html"', sbody)
sbody = re.sub('a href="(\w+?)"', 'a href="\g<1>.html"', sbody)
sbody = re.sub('\<h(\d)\>(.+?)\<\/h(\d)\>', 
               lambda m: '<h%s id="%s">%s</h%s>' % (m.group(1),
                                                    m.group(2).replace(' ','-'),
                                                    m.group(2),
                                                    m.group(3)), 
               sbody)
try:
    title = re.search('<h1.*?>(.+?)</h1>', sbody).group(1)
except:
    title = src.replace('.html', '')
newbody = template % {
    'title': title,
    'body': sbody,
    'styles': styles,}
open(dest, mode='w').write(newbody)
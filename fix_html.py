import os
import sys
import re
md_base = '' # '../'
gitlab_base = 'https://github.com/bitdust-io/public/blob/master/'
template = open('template.html').read()
src = sys.argv[1]
dest = sys.argv[2]
basepath = ''
if len(sys.argv) > 3:
    basepath = sys.argv[3]
if not os.path.isdir(os.path.dirname(dest)):
    print "create", os.path.dirname(dest)
    os.makedirs(os.path.dirname(dest))
site_url = "https://bitdust.io"
sbody = open(src).read()
sbody = re.sub('a href="(.+?)\.md"', 'a href="%s\g<1>.html"' % md_base, sbody)
sbody = re.sub('a href="(.+?)\.py"', 'a href="%s\g<1>.py"' % gitlab_base, sbody)
sbody = re.sub('a href="../docs/(.+?)\.html"', 'a href="\g<1>.html"', sbody)
sbody = re.sub('a href="docs/(.+?)\.html"', 'a href="\g<1>.html"', sbody)
sbody = re.sub('\>\<img alt="', '><img width=1000 alt="', sbody) 
sbody = re.sub('a href="(\w+?)"', 'a href="\g<1>.html"', sbody)
sbody = re.sub('a href="#(.+?)"', 'a href="%s#\g<1>"' % os.path.basename(src), sbody)
sbody = re.sub('\<p\>\<style', '<style', sbody)
sbody = re.sub('\</style\>\</p\>', '</style>', sbody)
sbody = re.sub('\<h(\d)\>(.+?)\<\/h(\d)\>', 
               lambda m: '<h%s id="%s">%s</h%s>' % (m.group(1),
                                                    m.group(2).replace(' ','-').lower(),
                                                    m.group(2),
                                                    m.group(3)), 
               sbody)
# sbody = sbody.replace(
    # '<div class=fbcomments markdown="1">', 
    # '<div class="fb-comments" data-href="%s/%s" data-width="500" data-numposts="5">' % (
        # site_url, os.path.basename(dest)))
sbody = sbody.replace(
    '<div class=fbcomments>', 
    '<div class="fb-comments" data-href="%s/%s" data-numposts="5" data-width="100%%" data-colorscheme="light">' % (
        site_url, os.path.basename(dest)))        
try:
    title = re.search('<h1.*?>(.+?)</h1>', sbody).group(1)
except:
    title = src.replace('.html', '')
newbody = template % {
    'title': title,
    'body': sbody, 
    'basepath': basepath,
    'site_url': site_url,
    'filepath': os.path.basename(dest)}
open(dest, mode='w').write(newbody)
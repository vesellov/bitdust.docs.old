import sys
import markdown2
import codecs
import locale
markdowner = markdown2.Markdown(extras=['markdown-in-html', 
                                        'tables',])
mdsrc = codecs.open(sys.argv[1], mode='r').read().decode('utf8')
htmlsrc = markdowner.convert(mdsrc)
sys.stdout.write(htmlsrc.encode(locale.getpreferredencoding()))
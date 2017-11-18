import os
import sys

subdir = sys.argv[1]

for fn in os.listdir(subdir):
    if not fn.endswith('.md'):
        continue
    fp = os.path.join(subdir, fn)
    fphtml = os.path.join("@build", subdir, fn[:-3] + '.html')
#    fppngsource = os.path.join(dirpath, fn[:-3]+'.png')
#    fppdfsource = os.path.join(dirpath, fn[:-3]+'.pdf')
    try:
        if not os.path.isdir(os.path.dirname(fphtml)):
            os.makedirs(os.path.dirname(fphtml))
            print "create", os.path.dirname(fphtml)
#        if os.system('cp -rf %s/%s %s' % (dirpath, fn, subdir)):
#            break
#        if os.path.isfile(fppngsource):        
#            if os.system('cp -rf %s %s' % (fppngsource, subdir)):
#                pass
#        if os.path.isfile(fppdfsource):     
#            if os.system('cp -rf %s %s' % (fppdfsource, subdir)):
#                pass        
        if os.system('python md2html.py %s > %s' % (fp, fphtml)):
            break
        if os.system('python fix_html.py %s %s %s' % (fphtml, fphtml, '../')):
            break
    except:
        import traceback
        traceback.print_exc()
        break
    
    print os.path.basename(fphtml)
    
    
    
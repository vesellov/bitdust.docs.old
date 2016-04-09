import re
import os
import sys

method_rexp = '^def\s+(\w+)\((.*?)\)\:$'

fin = open(sys.argv[1])
fout = open(sys.argv[2], 'w')
fout.write('# BitDust API\n\n')

while True:
    line = fin.readline()
    if line == '':
        break
    r = re.match(method_rexp, line.strip())
    if not r:
        continue
    method = r.group(1)
    params = r.group(2)
    comment = ''
    if method.startswith('_'):
        continue
    if method in ['OK', 'RESULT', 'ERROR', 'on_api_result_prepared']:
        continue
    line = fin.readline()
    if line == '':
        break
    if line and (line.strip().startswith('"""') or line.strip().startswith("'''")):
        if line.count('"""') == 2 or line.count("'''") == 2:
            comment = line.strip('"""').strip("'''").replace('"""','').replace("'''",'').replace('    ', '', 1)
        else:
            comment = line.replace('    ', '', 1)
            while True:
                line = fin.readline()
                if line == '':
                    break
                comment += line.replace('    ', '', 1)
                if line.count('"""') or line.count("'''"):
                    break
            comment = comment.strip('"""').strip("'''").replace('"""','').replace("'''",'')
    comment = comment.replace('Return:', '')
    print '%s(%s)' % (method, params)
    fout.write('### %s(%s)\n' % (method.replace('_','\_'), params.replace('_','\_')))
    fout.write(('\n'.join(comment.splitlines())) + '\n\n')

fout.write('\n\n')
fout.close()
fin.close()

head = """
# Settings


## Command line syntax


Read single setting value:
    
    bitdust set <option name>
    

Write single setting value:

    bitdust set <option name> <new value>


List all available settings and its current values:

    bitdust set list


## List of options
"""

config_tpl = """### {label} ({typ})

{path}, default value: {default}

{info}

"""


import os
import sys

sys.path.append(sys.argv[1])

from main import config
from main import settings
settings.init()

fout = open(sys.argv[2], 'w')

fout.write(head)

for name in sorted(config.conf().listAllEntries()):
    fout.write(config_tpl.format(
        label=config.conf().getLabel(name) or name,
        path=name,
        typ=config.conf().getTypeLabel(name),
        default=config.conf().getDefaultValue(name),
        info=config.conf().getInfo(name),
    ))
    sys.stdout.write('.')

sys.stdout.write('\n')
fout.write('\n\n')
fout.close()

import os
import sys

sys.path.append(os.path.realpath(os.path.expanduser(
    '~/Documents/Github/PyAid/src'
)))
sys.path.append(os.path.realpath(os.path.expanduser(
    '~/Documents/Github/Nimble/src'
)))

from nimble import cmds
from nimble import actions

print('STARTED')

result = cmds.polyCube()
print('CREATED CUBE:', result)

response = actions.render(directory='/output', name='test2')

if response.success:
    print('RENDER COMPLETE')
    print(response.result)
else:
    print('RENDER FAILED')

# libraries
import os
from zipfile import ZipFile
from catppuccin import PALETTE
import re

# read properties.xml
file = open('properties.xml', 'r')
theme = file.read()
file.close()

# generate all flavors
for flavor in PALETTE:
    with ZipFile('output/mixplorer-catppuccin-' + flavor.name + '.zip', 'w') as flavor_zip:
        print('generating ' + flavor.name)

        # get colors
        colors = {}
        for accent in flavor.colors:
            colors[accent.identifier] = re.sub(r'^#', '', accent.hex)

        # generate flavors
        for accent in flavor.colors:
            if accent.accent:
                def replaceValues(match):
                    v = match.group(1)
                    if v == 'flavorName':
                        return flavor.name
                    elif v == 'accentName':
                        return accent.name
                    elif v == 'accent':
                        return colors[accent.identifier]
                    elif colors.get(v):
                        return colors[v]

                result = re.sub(r'{{([\w\s]+?)}}', replaceValues, theme)
                with ZipFile('output/temp.zip', 'w') as accentZip:
                    accentZip.writestr('properties.xml', result)
                flavor_zip.write('output/temp.zip', 'mixplorer-catppuccin-' + flavor.name + '-' + accent.name + '.mit')

# remove temporary file
os.remove("output/temp.zip")
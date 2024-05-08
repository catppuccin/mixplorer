import os
from zipfile import ZipFile

flavors = ['latte', 'frappe', 'macchiato', 'mocha']
for flavor in flavors:
    file = open('output/' + flavor + '.xml', 'r')
    theme = file.read()
    file.close()
    file = open('output/' + flavor + '.txt', 'r')
    accents = file.read()
    file.close()
    with ZipFile('output/mixplorer-catppuccin-' + flavor + '.zip', 'w') as flavor_zip:
        for accent in accents.split('\n'):
            accentData = accent.split(':') # name, color
            with ZipFile('output/temp.zip', 'w') as zip_obj:
                zip_obj.writestr('properties.xml', theme.replace('${accent}', accentData[1]).replace('${accentName}', accentData[0]))
            flavor_zip.write('output/temp.zip', 'mixplorer-catppuccin-' + flavor + '-' + accentData[0] + '.mit')
    print('saved output/mixplorer-catppuccin-'  + flavor + '.zip')
os.remove("output/temp.zip")
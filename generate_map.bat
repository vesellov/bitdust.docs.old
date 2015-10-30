@echo off


@echo [ build area ]
python build_area.py ../bitdust/services/html_src/services_png_1.htm


@echo [ create "map.html" ]
python -c "s=open('map.template').read();s=s.replace('{area}',open('area').read());open('map.html','w').write(s);"
cp ../bitdust/services/html_src/services_png_1.png services.png 


@echo [ DONE ]

pause

api:
	@echo "API"
	@python build_api.py ../bitdust.devel/interface/api.py api.md
    
settings:
	@echo "settings"
	@python build_settings.py ../bitdust.devel/ settings.md

build: api settings
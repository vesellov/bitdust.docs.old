api:
	@echo "API"
	@python build_api.py ../bitdust.devel/interface/api.py api.md
    
settings:
	@echo "settings"
	@python build_settings.py ../bitdust.devel/ settings.md

sphinx:
	@echo "sphinx-build"
	@cp -R sphinx_conf/* _rst/
	@sphinx-build -b html _rst _rst/_build/html

sphinxrst:
	@echo "sphinx-apidoc"
	@rm -rf _rst/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/automats/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/contacts/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/chat/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/crypt/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/customer/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/dht/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/interface/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/lib/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/logs/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/main/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/p2p/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/parallelp/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/raid/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/services/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/storage/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/stun/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/supplier/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/system/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/transport/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/updates/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/userid/
	@sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/web/
	# @sphinx-apidoc -e -P -H BitDust -o _rst/ ../bitdust.devel/

build: api settings
V=20220331

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 deepin{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/deepin{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
dist:
	git archive --format=tar --prefix=deepin-keyring-$(V)/ master | gzip -9 > deepin-keyring-$(V).tar.gz
	gpg --default-key BA266106 --detach-sign --use-agent deepin-keyring-$(V).tar.gz

upload:
	rsync --chmod 644 --progress deepin-keyring-$(V).tar.gz deepin-keyring-$(V).tar.gz.sig deepin.org:/nginx/var/www/keyring/

.PHONY: install uninstall dist upload


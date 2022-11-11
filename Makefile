#!/usr/bin/env bash
ifndef PREFIX
  PREFIX = /usr/
endif

default:build

build:build-gtk4

build-gtk4:
	valac --pkg gtk4 launcher4.vala -o alephone-launcher

build-gtk3:
	valac --pkg gtk+-3.0 launcher3.vala -o alephone-launcher

clean:
	rm -f alephone-launcher

install:
	mkdir -p ${PREFIX}/bin
	mkdir -p ${PREFIX}/share/applications
	mkdir -p ${PREFIX}/share/icons/hicolor/128x128/apps/
	install -m 0755 launcher ${PREFIX}/bin/marathon-launcher
	install -m 0644 marathon-launcher.desktop ${PREFIX}/share/applications/
	install -m 0644 marathon_128.png ${PREFIX}/share/icons/hicolor/128x128/apps/
	install -m 0644 marathon_128.png ${PREFIX}/share/icons/

uninstall:
	rm -f ${PREFIX}/bin/marathon-launcher
	rm -f ${PREFIX}/share/applications/marathon-launcher.desktop
	rm -f ${PREFIX}/share/icons/hicolor/128x128/apps/marathon_128.png
	rm -f ${PREFIX}/share/doc/alephone-marathon-launcher


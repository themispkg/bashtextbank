PREFIX	:= ""
BINDIR	:= $(PREFIX)/usr/bin
LIBDIR	:= "/usr/local/lib/bash"

define setup
	install -m 755 ./src/btbshell.sh ${BINDIR}/btbshell
	install -m 755 ./lib/bashtextbank.sh ${LIBDIR}
endef

define remove
	rm -f ${LIBDIR}/bashtextbank.sh ${BINDIR}/btbshell
endef

install:
	cd bash-utils ; make install
	$(setup)

uninstall:
	$(remove)

reinstall:
	$(remove)
	cd bash-utils ; make install
	$(setup)
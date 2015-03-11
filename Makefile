TARGETS = memcldj

all: $(TARGETS)

memcldj: imports
	go build -o memcldj cmd/memcldj/main.go

imports:
	goimports -w .

clean:
	rm -f $(TARGETS)
	rm -f memcldj_*deb
	rm -f memcldj-*rpm
	rm -rf ./packaging/deb/memcldj/usr

deb: $(TARGETS)
	mkdir -p packaging/deb/memcldj/usr/sbin
	cp $(TARGETS) packaging/deb/memcldj/usr/sbin
	cd packaging/deb && fakeroot dpkg-deb --build memcldj .
	mv packaging/deb/memcldj_*.deb .

rpm: $(TARGETS)
	mkdir -p $(HOME)/rpmbuild/{BUILD,SOURCES,SPECS,RPMS}
	cp ./packaging/rpm/memcldj.spec $(HOME)/rpmbuild/SPECS
	cp $(TARGETS) $(HOME)/rpmbuild/BUILD
	./packaging/rpm/buildrpm.sh memcldj
	cp $(HOME)/rpmbuild/RPMS/x86_64/memcldj*.rpm .

cloc:
	cloc --max-file-size 1 .

NIVPLUSFNAME=nivplus-r2_1.zip
NIVPLUSLOCATION=http://mooses.nl/nice/relatedprojects/nivplus/latest/release

NICEFNAME=nice-bin-full-r11dot6a.zip
NICELOCATION=http://mooses.nl/nice/releases/R11dot6a

NOCTISFNAME=fpWeynNgjr7i2W4.zip
NOCTISLOCATION=http://anynowhere.com/bb/cd/zips

NoctdiskII.zip: noctis nice nivplus common/readme.pdf
	cd common && zip -r ../NoctdiskII.zip *
	zip -r NoctdiskII.zip noctis nice nivplus

clean:
	rm -rf noctis nice nivplus
	rm -f "$(NOCTISFNAME)" "$(NICEFNAME)" "$(NIVPLUSFNAME)"
	rm -f  NoctdiskII.zip

noctis:
	wget "$(NOCTISLOCATION)/$(NOCTISFNAME)" -O"$(NOCTISFNAME)"
	unzip -dnoctis "$(NOCTISFNAME)"
	[ -e noctis/modules/NOCTIS.EXE ] || exit 1

nice:
	wget "$(NICELOCATION)/$(NICEFNAME)" -O"$(NICEFNAME)"
	unzip -dnice "$(NICEFNAME)"
	[ -e nice/modules/noctis.exe ] || exit 1

nivplus:
	wget "$(NIVPLUSLOCATION)/$(NIVPLUSFNAME)" -O"$(NIVPLUSFNAME)"
	unzip -dnivplus "$(NIVPLUSFNAME)"
	[ -e nivplus/modules/NOCTIS.EXE ] || exit 1

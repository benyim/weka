#
# $Revision: 1.21 $
#

JAVAC = javac

.PHONY: all optimized debug clean install archive doc

all : 
	(cd core; make all JAVAC=$(JAVAC))
	(cd classifiers; make all JAVAC=$(JAVAC))
	(cd filters; make all JAVAC=$(JAVAC))
	(cd estimators; make all JAVAC=$(JAVAC))
	(cd associations; make all JAVAC=$(JAVAC))
	(cd clusterers; make all JAVAC=$(JAVAC))
	(cd attributeSelection; make all JAVAC=$(JAVAC))
	(cd experiment; make all JAVAC=$(JAVAC))
	(cd gui; make all JAVAC=$(JAVAC))

optimized : 
	(cd core; make optimized JAVAC=$(JAVAC))
	(cd classifiers; make optimized JAVAC=$(JAVAC))
	(cd filters; make optimized JAVAC=$(JAVAC))
	(cd estimators; make optimized JAVAC=$(JAVAC))
	(cd associations; make optimized JAVAC=$(JAVAC))
	(cd clusterers; make optimized JAVAC=$(JAVAC))
	(cd attributeSelection; make optimized JAVAC=$(JAVAC))
	(cd experiment; make optimized JAVAC=$(JAVAC))
	(cd gui; make optimized JAVAC=$(JAVAC))

debug :
	(cd core; make debug JAVAC=$(JAVAC))
	(cd classifiers; make debug JAVAC=$(JAVAC))
	(cd filters; make debug JAVAC=$(JAVAC))
	(cd estimators; make debug JAVAC=$(JAVAC))
	(cd associations; make debug JAVAC=$(JAVAC))
	(cd clusterers; make debug JAVAC=$(JAVAC))
	(cd attributeSelection; make debug JAVAC=$(JAVAC))
	(cd experiment; make debug JAVAC=$(JAVAC))
	(cd gui; make debug JAVAC=$(JAVAC))

clean : 
	(cd core; make clean)
	(cd classifiers; make clean) 
	(cd filters; make clean)
	(cd estimators; make clean)
	(cd associations; make clean)
	(cd clusterers; make clean)
	(cd attributeSelection; make clean)
	(cd experiment; make clean)
	(cd gui; make clean)

doc :
	(cd ..; \
	javadoc -J-mx100m -public -author -version -d doc \
	weka.core \
	weka.classifiers \
	weka.classifiers.j48 \
	weka.classifiers.m5 \
	weka.classifiers.kstar \
	weka.filters \
	weka.estimators \
	weka.associations \
	weka.clusterers \
	weka.attributeSelection \
	weka.experiment \
	weka.gui \
	weka.gui.experiment \
	weka.gui.explorer \
	weka.gui.explorer.treevisualizer \
	weka.gui.streams \
	for page in `ls doc/*.html`; \
	do cat $$page | sed "s/Index<\/a><\/pre>/Index<\/a>  <a href=\"http:\/\/www.cs.waikato.ac.nz\/ml\/weka\/index.html\">WEKA\'s home<\/a><\/pre>/g" > $$page.temp; mv $$page.temp $$page; done;\
	sed 's/API_users_guide.html/..\/Tutorial.pdf/g' \
	< doc/packages.html > packages_temp.html; \
	mv packages_temp.html doc/packages.html)

# Assumes any auxiliary classfiles are in the parent directory
# One of these must be SimpleCLI.class
install : all
	(cd ..; \
	echo "Main-Class: weka.gui.GUIChooser" > manifest.tmp ;\
	jar cvfm $$JAWSHOME/weka.jar manifest.tmp \
	weka/core/*.class \
	weka/classifiers/*.class \
	weka/classifiers/j48/*.class \
	weka/classifiers/m5/*.class \
	weka/classifiers/kstar/*.class \
	weka/filters/*.class \
	weka/estimators/*class \
	weka/associations/*.class \
	weka/clusterers/*.class \
	weka/attributeSelection/*.class \
	weka/experiment/*.class \
	weka/experiment/*.props \
	weka/gui/*.class \
	weka/gui/*.props \
	weka/gui/*.jpg \
	weka/gui/*.gif \
	weka/gui/experiment/*.class \
	weka/gui/explorer/*.class \
	weka/gui/explorer/treevisualizer/*.class \
	weka/gui/streams/*.class \
	; \
	jar cvf $$JAWSHOME/weka-src.jar \
	weka/core/*.java \
	weka/classifiers/*.java \
	weka/classifiers/j48/*.java \
	weka/classifiers/m5/*.java \
	weka/classifiers/kstar/*.java \
	weka/filters/*.java \
	weka/estimators/*java \
	weka/associations/*.java \
	weka/clusterers/*.java \
	weka/attributeSelection/*.java \
	weka/experiment/*.java \
	weka/gui/*.java \
	weka/gui/experiment/*.java \
	weka/gui/explorer/*.java \
	weka/gui.explorer/treevisualizer/*.java \
	weka/gui/streams/*.java \
	;\
	rm manifest.tmp )
	javadoc -J-mx100m -public -author -version -d $$JAWSHOME/doc \
	weka.core \
	weka.classifiers \
	weka.classifiers.j48 \
	weka.classifiers.m5 \
	weka.classifiers.kstar \
	weka.filters \
	weka.estimators \
	weka.associations \
	weka.clusterers \
	weka.attributeSelection \
	weka.experiment \
	weka.gui \
	weka.gui.experiment \
	weka.gui.explorer \
	weka.gui.explorer.treevisualizer \
	weka.gui.streams; \
	for page in `ls $$JAWSHOME/doc/*.html`; \
	do cat $$page | sed "s/Index<\/a><\/pre>/Index<\/a>  <a href=\"http:\/\/www.cs.waikato.ac.nz\/ml\/weka\/index.html\">WEKA\'s home<\/a><\/pre>/g" > $$page.temp; mv $$page.temp $$page; done;\
	sed 's/API_users_guide.html/..\/Tutorial.pdf/g' \
	< $$JAWSHOME/doc/packages.html > $$JAWSHOME/packages_temp.html; \
	mv $$JAWSHOME/packages_temp.html $$JAWSHOME/doc/packages.html

archive :
	(cd ..; \
	tar czf archive/weka`date +%d%b%Y`.tar.gz  weka)






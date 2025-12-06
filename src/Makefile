GODOT=godot
PROJECT_FILE_LOCATION=godot/project.godot
BINS_LOCATION=~/Documents/fuyu_bins

run:
	$(GODOT) $(PROJECT_FILE_LOCATION)
	echo "Projet lancé."


build:
	godot $(PROJECT_FILE_LOCATION) --export-release "Windows Desktop" tmp_builds/game.exe
	godot $(PROJECT_FILE_LOCATION) --export-release "macOS" tmp_builds/game.app
	godot $(PROJECT_FILE_LOCATION) --export-release "Linux" tmp_builds/game.x86-64
	echo "Construction du projet terminée."

export:
	mkdir $(BINS_LOCATION)/win $(BINS_LOCATION)/macos $(BINS_LOCATION)/linux
	cp godot/tmp_builds/game.exe $(BINS_LOCATION)/win/
	cp godot/tmp_builds/game.pck $(BINS_LOCATION)/macos/
	mkdir $(BINS_LOCATION)/macos/game.app/ && cp -r godot/tmp_builds/game.app/** $(BINS_LOCATION)/macos/game.app/
	cp godot/tmp_builds/game.x86-64 $(BINS_LOCATION)/linux/
	echo "Export du projet terminé."

clean:
	rm -rf $(BINS_LOCATION)/win
	rm -rf $(BINS_LOCATION)/macos
	rm -rf $(BINS_LOCATION)/linux
	rm -rf godot/tmp_builds/**
	echo "Projet nettoyé."

publish: clean build export

function getFilesFromFolder(packageName,folder,filter){
	// local imports
	var _ = Npm.require("underscore");
	var fs = Npm.require("fs");
	var path = Npm.require("path");

	// helper function, walks recursively inside nested folders and return absolute filenames
	function walk(folder){
		var filenames = [];
		// get relative filenames from folder
		var folderContent = fs.readdirSync(folder);
		// iterate over the folder content to handle nested folders
		_.each(folderContent,function(filename){
			// build absolute filename
			var absoluteFilename = folder + path.sep + filename;
			// get file stats
			var stat = fs.statSync(absoluteFilename);
			if(stat.isDirectory()){
				// directory case  = > add filenames fetched from recursive call
				filenames = filenames.concat(walk(absoluteFilename));
			}
			else{
				// file case => simply add it
				filenames.push(absoluteFilename);
			}
		});

		return filenames;
	}
	// save current working directory (something like "/home/user/projects/my-project")
	var cwd = process.cwd();

	// chdir to our package directory
	process.chdir("packages"+path.sep+packageName);

	// launch initial walk
	var result = walk(folder);
	// restore previous cwd
	process.chdir(cwd);


	if(filter){
		regex = new RegExp(filter)
		result = _.filter(result, function(filename) {
			return regex.test(filename);
		});
	}

	return result;
}

Package.describe({
	name: "gildaspk:mysessions-mobile",
	summary: "mySessions - the mobile application",
	version: "0.0.1"
});

Package.on_use(function (api) {
	api.use('templating', 'client');
	api.use('underscore', 'client');
	api.use('coffeescript', 'client');
	api.use('less', 'client');
	api.use('tap:i18n', 'client');
	api.use('mongo', 'client');
	api.use('gildaspk:mysessions-core', 'client');
	api.use('useraccounts:core', 'client');
	api.use('raix:handlebar-helpers', 'client');
	api.use('iron:router', 'client');
	api.use('fourseven:scss@=1.0.0', 'client');
	api.use('meteoric:ionic-sass@0.1.7', 'client');
	api.use('meteoric:ionicons-sass@0.1.5', 'client');
	api.use('meteoric:ionic', 'client');
	api.use('meteoric:autoform-ionic', 'client');
	api.use('useraccounts:ionic', 'client');

	api.imply('meteoric:ionic', 'client');

	api.add_files([
		"compatibility/velocity.js",
		"compatibility/velocity.ui.js",
	], 'client');

	api.add_files([
		"accounts-templates.coffee"
		], 'client');

	api.add_files([
		"settings/lib.coffee"
		], 'client');

	api.add_files([
		"shared/templates.html",
		"shared/events.coffee",
		"shared/helpers.coffee",
		"shared/router.coffee",
	], 'client');

	api.add_files([
		"home/templates.html",
		"home/events.coffee",
		"home/routes.coffee",
	], 'client');

	api.add_files([
		"courses/templates.html",
		"courses/events.coffee",
		"courses/routes.coffee",
	], 'client');

	api.add_files([
		"sessions/templates.html",
		"sessions/routes.coffee",
	], 'client');

	api.add_files([
		"styles.scss",
	], 'client');

	api.add_files([
		"shared/startup.coffee",
	], 'client');

	api.export("Settings");
});

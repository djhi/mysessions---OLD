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

	var result = [];

	if (fs.existsSync(folder)) {
		// launch initial walk
		result = walk(folder);
		// restore previous cwd
		process.chdir(cwd);

		if(filter){
			regex = new RegExp(filter)
			result = _.filter(result, function(filename) {
				return regex.test(filename);
			});
		}
	}

	return result;
}

Package.describe({
	name: "gildaspk:mysessions-web",
	summary: "mySessions - the web application",
	version: "0.0.1"
});

Package.on_use(function (api) {
	api.use('templating', 'web.browser');
	api.use('underscore', 'web.browser');
	api.use('coffeescript', 'web.browser');
	api.use('less', 'web.browser');
	api.use('tap:i18n', 'web.browser');
	api.use('mongo', 'web.browser');
	api.use('gildaspk:mysessions-core', 'web.browser');
	api.use('useraccounts:core', 'web.browser');
	api.use('useraccounts:bootstrap', 'web.browser');
	api.use('raix:handlebar-helpers', 'web.browser');
	api.use('iron:router', 'web.browser');
	api.use('zimme:iron-router-active', 'web.browser');
	api.use('gildaspk:moment-datepicker', 'web.browser');
	api.use('zimme:bootstrap-growl', 'web.browser');
	api.use('anti:modals', 'web.browser');
	api.use('jeremy:selectize', 'web.browser');

	api.add_files([
		"compatibility/bootstrap.js",
		"compatibility/selectize.js",
		"compatibility/velocity.js",
		"compatibility/velocity.ui.js",
	], 'web.browser');

	api.add_files([
		"accounts-templates.coffee"
	], 'web.browser');

	api.add_files([
		"helpers/notifications.coffee"
	], 'web.browser');

	api.add_files([
		"lib/autoform.coffee",
		"lib/router.coffee",
	], 'web.browser');

	api.add_files([
		"routes/config.coffee",
		"routes/courses.coffee",
		"routes/participants.coffee",
		"routes/sessions.coffee",
		"routes/main.coffee",
		], 'web.browser');

	api.add_files([
		"stylesheets/mixins.less",
	], 'web.browser');

	api.add_files(getFilesFromFolder('mysessions-web', 'stylesheets/lib/bootstrap'), 'web.browser');
	api.add_files(getFilesFromFolder('mysessions-web', 'stylesheets/lib/fontawesome'), 'web.browser');
	api.add_files([
		"stylesheets/lib/selectize.bootstrap3.less",
		"stylesheets/lib/theme.variables.import.less",
		"stylesheets/lib/theme.import.less",
	], 'web.browser');
	api.add_files(getFilesFromFolder('mysessions-web', 'stylesheets/components'), 'web.browser');

	api.add_files([
		"stylesheets/main.less",
	], 'web.browser');

	api.add_files(getFilesFromFolder('mysessions-web', 'assets/fonts'), "web.browser", { isAsset: true })

	api.add_files("package-tap.i18n", 'web.browser');
	api.add_files(getFilesFromFolder('mysessions-web', 'views', '\\.html'), 'web.browser');
	api.add_files(getFilesFromFolder('mysessions-web', 'views', '\\.coffee'), 'web.browser');
});

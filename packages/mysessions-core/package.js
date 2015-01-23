Package.describe({
	name: "gildaspk:mysessions-core",
	summary: "mySessions - core package",
	version: "0.0.1"
});

Package.on_use(function (api) {
	both = ["client", "server"]

	api.use('meteor-platform', both);
	api.use('alethes:lodash', both);
	api.use('templating', 'client');
	api.use('underscore', both);
	api.use('coffeescript', both);
	api.use('check', both);
	api.use('aldeed:simple-schema', both);
	api.use('aldeed:collection2', both);
	api.use('aldeed:autoform', both);
	api.use('matb33:collection-hooks', both);
	api.use('dburles:collection-helpers', both);
	api.use('percolatestudio:percolatestudio-migrations', both);
	api.use('iron:router', both);
	api.use('accounts-ui', both);
	api.use('accounts-password', both);
	api.use('accounts-google', both);
	api.use('service-configuration', both);
	api.use('useraccounts:core', both);
	api.use('splendido:accounts-meld', both);
	api.use('mrt:moment@2.8.1', both);
	api.use('vsivsi:numeral@1.5.3_1', both);
	api.use('gildaspk:moment-languages', both);
	api.use('gildaspk:numeral-languages', both);
	api.use('u2622:persistent-session', both);
	api.use('wizonesolutions:underscore-string', both);
	api.use('tap:i18n', both);

	api.imply('meteor-platform', both);
	api.imply('templating', 'client');
	api.imply('underscore', both);
	api.imply('coffeescript', both);
	api.imply('check', both);
	api.imply('aldeed:simple-schema', both);
	api.imply('aldeed:autoform', both);
	api.imply('iron:router', both);
	api.imply('useraccounts:core', both);
	api.imply('splendido:accounts-meld', both);
	api.imply('mrt:moment@2.8.1', both);
	api.imply('vsivsi:numeral@1.5.3_1', both);
	api.imply('gildaspk:moment-languages', both);
	api.imply('gildaspk:numeral-languages', both);
	api.imply('tap:i18n', both);

	api.add_files([
		"lodash.coffee",
		], both);

	api.add_files([
		"collections/namespaces.coffee",
		"collections/lib/simple-schema-i18n.coffee",
		"collections/sub/sessionSummary.coffee",
		"collections/profile.coffee",
		"collections/reportRecipients.coffee",
		"collections/sessionReport.coffee",
		"collections/participant.coffee",
		"collections/course.coffee",
		"collections/session.coffee",
	], both);

	api.add_files([
		"hooks/courses.coffee",
		"hooks/participants.coffee",
		"hooks/sessions.coffee",
		], 'server');

	api.add_files([
		"security/lib/owner.coffee",
		"security/lib/userChecks.coffee",
		"security/collections.coffee",
		], 'server');

	api.add_files([
		"publications.coffee",
		], 'server');

	api.add_files([
		"accounts/accounts.coffee",
		], 'client');

	api.add_files([
		"accounts/accounts-emails.coffee",
		"accounts/accounts-meld.coffee",
		], 'server');

	api.add_files("package-tap.i18n", both);

	api.add_files([
		"i18n/i18n.coffee",
		"i18n/moment.coffee",
	], "client");

	api.add_files([
		"i18n/en.i18n.json",
		"i18n/fr.i18n.json",
		], both);

	api.add_files([
		"methods/GoogleContacts.coffee",
		"methods/getGoogleContacts.coffee",
		"methods/searchParticipantsByName.coffee",
		"methods/sendSessionReport.coffee",
		"methods/updateProfile.coffee",
		], 'server');

	api.add_files([
		"migrations/1.coffee",
		"migrations/2.coffee",
		"migrations/migrations.coffee",
	], 'server');

	api.export("SessionSummarySchema")
	api.export("SessionReportSchema")
	api.export("ParticipantSchema")
	api.export("Participants")
	api.export("CourseSchema")
	api.export("Courses")
	api.export("SessionSchema")
	api.export("Sessions")
	api.export("ReportRecipients")
	api.export("i18nHelper")
});

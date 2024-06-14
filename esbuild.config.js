const esbuild = require("esbuild");

esbuild
	.build({
		entryPoints: ["app/javascript/application.js"],
		bundle: true,
		outdir: "app/assets/builds",
		watch: process.env.NODE_ENV !== "production",
		loader: {
			".js": "jsx",
			".jsx": "jsx",
		},
		define: {
			"process.env.NODE_ENV": `"${process.env.NODE_ENV}"`,
		},
	})
	.catch(() => process.exit(1));

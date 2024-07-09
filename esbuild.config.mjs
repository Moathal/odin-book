import path from "path";
import rails from "esbuild-rails";
import esbuild from "esbuild";

esbuild
	.build({
		entryPoints: ["application.js"],
		bundle: true,
		outdir: path.join(process.cwd(), "app/assets/builds"),
    absWorkingDir: path.join(process.cwd(), "app/javascript"),
    resolveExtensions: ['.js', '.jsx'],
		plugins: [rails()],
	})
	.catch(() => process.exit(1));
